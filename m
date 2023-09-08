Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A1F799100
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 22:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbjIHUeg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 16:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjIHUeg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 16:34:36 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D808E;
        Fri,  8 Sep 2023 13:34:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E0603732;
        Fri,  8 Sep 2023 20:34:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E0603732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1694205270; bh=MDqJnX+WbR6SonVUJc2b/jr2kB7zjQHa9+7BCtZ8K2A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HTkoomFfydhscycwnKd3Cy9JPJ+BEWU99bVy1XpLrFCnWKMW1CV4/tdC2XtjtbO5t
         PTIgn9ZaMnT3Z7S7TkMeMYa+93uHTfbD725swExTm//fZ4BlPmpgp9EbCjgFTyHzUB
         KLZ1QEbzihpL7c7/ol1uYdiwqIFSWHTaLmyX/sHE3ALPXiYSRxdIwAzwxY311wXcRL
         hebiJpl7KFKV3t+IHOqNSFjOF7nDLjy3SahLBRBUBR23vWG/uVpo0DY0z7J6EPHGzw
         +IVmmMZqnaz7CAOuB/RXy9VY0qDIk2GVU/2jMyU2fYYPsKZLlTkzLhYsCSEMhQtvML
         Ck7Co0a4wQR/w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Michal Clapinski <mclapinski@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Yi Liu <yi.l.liu@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Steve French <stfrench@microsoft.com>,
        Simon Ser <contact@emersion.fr>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Luca Vizzarro <Luca.Vizzarro@arm.com>,
        Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Cc:     Michal Clapinski <mclapinski@google.com>
Subject: Re: [PATCH v2 0/2] mm/memfd: add ioctl(MEMFD_CHECK_IF_ORIGINAL)
In-Reply-To: <20230908175738.41895-1-mclapinski@google.com>
References: <20230908175738.41895-1-mclapinski@google.com>
Date:   Fri, 08 Sep 2023 14:34:29 -0600
Message-ID: <87tts4z9nu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Michal Clapinski <mclapinski@google.com> writes:

> This change introduces a way to check if an fd points to a memfd's
> original open fd (the one created by memfd_create).
>
> We encountered an issue with migrating memfds in CRIU (checkpoint
> restore in userspace - it migrates running processes between
> machines). Imagine a scenario:
> 1. Create a memfd. By default it's open with O_RDWR and yet one can
> exec() to it (unlike with regular files, where one would get ETXTBSY).
> 2. Reopen that memfd with O_RDWR via /proc/self/fd/<fd>.
>
> Now those 2 fds are indistinguishable from userspace. You can't exec()
> to either of them (since the reopen incremented inode->i_writecount)
> and their /proc/self/fdinfo/ are exactly the same. Unfortunately they
> are not the same. If you close the second one, the first one becomes
> exec()able again. If you close the first one, the other doesn't become
> exec()able. Therefore during migration it does matter which is recreated
> first and which is reopened but there is no way for CRIU to tell which
> was first.

So please bear with me...I'll confess that I don't fully understand the
situation here, so this is probably a dumb question.

It seems like you are adding this "original open" test as a way of
working around a quirk with the behavior of subsequent opens.  I don't
*think* that this is part of the intended, documented behavior of
memfds, it's just something that happens.  You're exposing an artifact
of the current implementation.

Given that the two file descriptors are otherwise indistinguishable,
might a better fix be to make them indistinguishable in this regard as
well?  Is there a good reason why the second fd doesn't become
exec()able in this scenario and, if not, perhaps that behavior could be
changed instead?

Thanks,

jon
