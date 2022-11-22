Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22BD633F9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 15:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiKVO7J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 09:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbiKVO6v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 09:58:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BFF6EB6C;
        Tue, 22 Nov 2022 06:56:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8ACF91F85D;
        Tue, 22 Nov 2022 14:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669128985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+loFO6tN5YXsk0bWjK2r+zKhS9ssoaTjODd0fLpHxXw=;
        b=sfmdqwbLKiTiB7Qi4AyDhjDIvCEMbXR1ZfivjEs/BqcOHbuhw+kprIf2xHCaCTwObQH8a5
        CKtGZ10w9JYjpD8IToot/jXIPHYlpgW+5ZS0wbEgEuQpU+1AM+/uz+jrOhnvYaznSjFawR
        lulkdeUJ9jy+oIMCVvY3OEkd0qOvieo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669128985;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+loFO6tN5YXsk0bWjK2r+zKhS9ssoaTjODd0fLpHxXw=;
        b=y42N2ZaNchVaRcELYmUf0n2LuOWXFda2EadO5JNkazxeFEBiX8E/BXEGx+KtlEgs/tzmrX
        8ds0XUjamiBkMUDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5594413B01;
        Tue, 22 Nov 2022 14:56:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e3sDFBnjfGMdBAAAMHmgww
        (envelope-from <mdoucha@suse.cz>); Tue, 22 Nov 2022 14:56:25 +0000
Message-ID: <9489dd1c-012c-8b5d-b670-a27213da287a@suse.cz>
Date:   Tue, 22 Nov 2022 15:56:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>, Petr Vorel <pvorel@suse.cz>,
        ltp@lists.linux.it, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitin Gupta <ngupta@vflare.org>, Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com> <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
 <Y22b3wWs2QfMjJHi@google.com>
Content-Language: en-US
From:   Martin Doucha <mdoucha@suse.cz>
Subject: Re: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
In-Reply-To: <Y22b3wWs2QfMjJHi@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11. 11. 22 1:48, Sergey Senozhatsky wrote:
> On (22/11/10 15:29), Martin Doucha wrote:
>> I've tried to debug the issue and collected some interesting data (all
>> values come from zram device with 25M size limit and zstd compression
>> algorithm):
>> - mm_stat values are correct after mkfs.vfat:
>> 65536      220    65536 26214400    65536        0        0        0
>>
>> - mm_stat values stay correct after mount:
>> 65536      220    65536 26214400    65536        0        0        0
>>
>> - the bug is triggered by filling the filesystem to capacity (using dd):
>> 4194304        0        0 26214400   327680       64        0        0
> 
> Can you try using /dev/urandom for dd, not /dev/zero?
> Do you still see zeroes in sysfs output or some random values?

After 50 test runs on a kernel where the issue is confirmed, I could not 
reproduce the failure while filling the device from /dev/urandom instead 
of /dev/zero. The test reported compression ratio around 1.8-2.5 which 
means the memory usage reported by mm_stat was 10-13MB.

Note that I had to disable the other filesystems in the test because 
some of them kept failing with compression ratio <1.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

