Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC25E6F4708
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 17:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbjEBPYE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 11:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbjEBPYC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 11:24:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0CC2733;
        Tue,  2 May 2023 08:24:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2887F221E4;
        Tue,  2 May 2023 15:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683041040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CW2LmtNuVSk94mDGCMJ1mJ80jVCNsh4d9/7vaIxHDh4=;
        b=zmNqwLSpBWozv3WsgFDqblkqkj9YdB1XZJul6aUiQSjbiUCMHugcr7A/qB/Fc8IZEgsQuy
        W5QfK5czrPgcnazCSULSiL7uuPkMs+eozDD0QfQIt8ZSFFR3hmCYWD4F7G/QyyCJ5IwVwO
        NIFVSlNrRVnz1UsSSyNMx1F255/Ky/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683041040;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CW2LmtNuVSk94mDGCMJ1mJ80jVCNsh4d9/7vaIxHDh4=;
        b=QPq4qeoLoFSA33UzVko5Z22yyv8ooaSf9wwviyeAHUoGDVBMTeOEUBFtQ6Gt3OJt7/tFNo
        DTzIsExRsdEGGQCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9F9F134FB;
        Tue,  2 May 2023 15:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id erhcLw8rUWQGIAAAMHmgww
        (envelope-from <mdoucha@suse.cz>); Tue, 02 May 2023 15:23:59 +0000
Message-ID: <e61e2dd0-3ce6-e849-8ce8-2b9aeb236c69@suse.cz>
Date:   Tue, 2 May 2023 17:23:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Vorel <pvorel@suse.cz>
Cc:     Minchan Kim <minchan@kernel.org>, ltp@lists.linux.it,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>,
        Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com> <3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz>
 <Y22b3wWs2QfMjJHi@google.com> <9489dd1c-012c-8b5d-b670-a27213da287a@suse.cz>
 <Y3zlrBQ8fgJyNm7G@pevik> <Y4WMxqyVlAt0Sp3g@google.com>
Content-Language: en-US
From:   Martin Doucha <mdoucha@suse.cz>
Subject: Re: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
In-Reply-To: <Y4WMxqyVlAt0Sp3g@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 29. 11. 22 5:38, Sergey Senozhatsky wrote:
> On (22/11/22 16:07), Petr Vorel wrote:
>> Martin, thanks a lot for reruning tests. I wonder problems on /dev/zero is a
>> kernel bug or just problem which should be workarounded.
> 
> Hmm. Does CONFIG_KASAN show anything interesting?

Sorry for the delay. We've tried to reproduce the bug with CONFIG_KASAN 
enabled but the only affected arch is PPC64LE and KASAN is not available 
there at all. Our kernel maintainers confirmed that if we need KASAN to 
debug this, we're out of luck.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

