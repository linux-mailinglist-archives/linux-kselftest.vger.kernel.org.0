Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9FB79182C
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 15:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353031AbjIDNbo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 09:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbjIDNbn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 09:31:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34F6CD4;
        Mon,  4 Sep 2023 06:31:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A2B721850;
        Mon,  4 Sep 2023 13:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693834295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8xUCxzGeN2LO3k4GTaJqu0a/S4SLZtY9yLR+6ymo9Vs=;
        b=hENeBDVLkufawqQjmFjPqwhRZIvJjxcIDlP0bIkA1w5p7ublUOu8Oo51GdSmSZDgVXWmZ6
        kexqUMTmBIhytvtR5+a6gQM6oARbu9IfN8oNDoPbRpBJMKyR6VIGi9cVDwP/FLxNpO6pjV
        n/tOqnnZmTmYgnFXin4d6qJgicYLRro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693834295;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8xUCxzGeN2LO3k4GTaJqu0a/S4SLZtY9yLR+6ymo9Vs=;
        b=xjzrCGoGMj18gFCc/jOlyZvo2Ugj5w7x1Z9epxL++2QXcflL9+LYzICqF2VXvv4OFKb7XU
        UIX9sdYQxVIzL/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E46D13585;
        Mon,  4 Sep 2023 13:31:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pN9CDjfc9WTiDgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 04 Sep 2023 13:31:35 +0000
Message-ID: <14b4a922-a31a-a329-0264-3d8bd101ee6b@suse.cz>
Date:   Mon, 4 Sep 2023 15:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Don't fill the kernel log with memfd_create messages
Content-Language: en-US
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Christian Brauner <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <1693408388.rwssx8r1h9.none.ref@localhost>
 <1693408388.rwssx8r1h9.none@localhost>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1693408388.rwssx8r1h9.none@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/30/23 17:52, Alex Xu (Hello71) wrote:
> Hi all,
> 
> Recently "memfd: improve userspace warnings for missing exec-related 
> flags" was merged. On my system, this is a regression, not an 
> improvement, because the entire 256k kernel log buffer (default on x86) 
> is filled with these warnings and "__do_sys_memfd_create: 122 callbacks 
> suppressed". I haven't investigated too closely, but the most likely 
> cause is Wayland libraries.
> 
> This is too serious of a consequence for using an old API, especially 
> considering how recently the flags were added. The vast majority of 
> software has not had time to add the flags: glibc does not define the 
> macros until 2.38 which was released less than one month ago, man-pages 
> does not document the flags, and according to Debian Code Search, only 
> systemd, stress-ng, and strace actually pass either of these flags.
> 
> Furthermore, since old kernels reject unknown flags, it's not just a 
> matter of defining and passing the flag; every program needs to 
> add logic to handle EINVAL and try again.
> 
> Some other way needs to be found to encourage userspace to add the 
> flags; otherwise, this message will be patched out because the kernel 
> log becomes unusable after running unupdated programs, which will still 
> exist even after upstreams are fixed. In particular, AppImages, 
> flatpaks, snaps, and similar app bundles contain vendored Wayland 
> libraries which can be difficult or impossible to update.

It's being reverted:
https://lore.kernel.org/all/20230902230530.6B663C433C8@smtp.kernel.org/

Meanwhile stable should avoid backporting 434ed3350f57 ("memfd: improve
userspace warnings for missing exec-related flags")

> Thanks,
> Alex.

