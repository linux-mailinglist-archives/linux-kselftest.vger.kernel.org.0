Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F66799207
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 00:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbjIHWHG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 18:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbjIHWHG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 18:07:06 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C7019B4;
        Fri,  8 Sep 2023 15:07:01 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1F552732;
        Fri,  8 Sep 2023 22:07:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1F552732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1694210821; bh=TzgHmaKz25GaV9E+TB8GN+i6D/XaAru3PQjEw55fRDw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jbfKXfK0mE9O3f5dMY3E4dVKm5jEKviPm3oJiS/gqHdTHREyIh+YUPuPXL72lLNqS
         qv6lR4nMb2tNem1jeiCHP60PTjurfc4Kkb4ybGEFDOcJybT0jNRotx+KtIURUK7hMx
         e8pKFsN3Ml2gc0P8UrrNG/Ff3N4kmnDWrqXWZirAEUeRCLoXqB2nE6nz/flhtm5ytw
         +kABmsUcQJNp+z7TePeUJI3hEVstmyGsVafoOoKy0j/uN2KcxJZRwvdtpIor09m53o
         dC1ddPZ03jJ7lhKjadb0ByajF8+STLOQc6rac31L3IPJyObUjVTVYsvpwaji5ZuV0n
         hbPucduHDXx9w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
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
Subject: Re: [PATCH v2 0/2] mm/memfd: add ioctl(MEMFD_CHECK_IF_ORIGINAL)
In-Reply-To: <CAAi7L5f1f3gHGr_8cCv2jW2Q5pjL9bpDD_4zrpXjXkoRmu95fg@mail.gmail.com>
References: <20230908175738.41895-1-mclapinski@google.com>
 <87tts4z9nu.fsf@meer.lwn.net>
 <CAAi7L5f1f3gHGr_8cCv2jW2Q5pjL9bpDD_4zrpXjXkoRmu95fg@mail.gmail.com>
Date:   Fri, 08 Sep 2023 16:07:00 -0600
Message-ID: <87h6o4z5dn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Micha=C5=82 C=C5=82api=C5=84ski <mclapinski@google.com> writes:

> On Fri, Sep 8, 2023 at 10:34=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> =
wrote:
>> Given that the two file descriptors are otherwise indistinguishable,
>> might a better fix be to make them indistinguishable in this regard as
>> well?  Is there a good reason why the second fd doesn't become
>> exec()able in this scenario and, if not, perhaps that behavior could be
>> changed instead?
>
> It probably could be changed, yes. But I'm worried that would be
> broadening the bug that is the exec()ability of memfds. AFAIK no other
> fd that is opened as writable can be exec()ed. If maintainers would
> prefer this, I could do this.

I'm not convinced that perpetuating the behavior and adding an ioctl()
workaround would be better than that; it seems to me that consistency
would be better.  But I don't have any real say in that matter, of
course; I'm curious what others think.

Thanks,

jon
