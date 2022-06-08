Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBB45425D2
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jun 2022 08:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiFHF37 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Jun 2022 01:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbiFHF0s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Jun 2022 01:26:48 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22241912C0
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Jun 2022 19:45:24 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p8so17149888pfh.8
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jun 2022 19:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hk2gCK5GcL5SvSh8UzW9g4jUcY4kzzvd/IMquDVjiO4=;
        b=c5O7ss6DupGlsVEU8Ms0R22mX91KC3Cg3PQV77Qd3ZaYVqNRwgL5voOoS6iRw8YI1g
         1FzQa46DGufTglDq0/urPNxV6ZEq9bIq7HEYZJAKAimhh0Y+HWX3PCzwu/g9oJ2qjr+B
         0NIWmFZ4Q6gwN4oyGaB+qEfjQ5LFeW/hzvOl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hk2gCK5GcL5SvSh8UzW9g4jUcY4kzzvd/IMquDVjiO4=;
        b=Hv4E//EQbsa01EonAtzq3LpLRY7pDYWy34TjPWcuuY80hbiPiCXCvobbZWFOzkb/+m
         at2c4y8BtdHCrvHN9RWv/+hYRknE8MrwmWet2rrlHRUmPqdQ5EkhpXXuaktpjIY2T5Lg
         TleeB9DvoHrFi04gm60/Sqov8+Ps8Fb7UGgDEQ4CSEEh3jMLLiMZw7V4qp0vzT5MD8sf
         s+PrzZDYHSfZd5sMxmpQytYtSSlOdJWB/3fMYU9dy3IoexXq1w1dwGn1gs+zRxnjYiLY
         XQ/jvrF/RlYtVe8lgqCJx7ZiHg+wlkx0D5Spd4br5Xbu2J0bci9ndJlZVR75J17IADdi
         ZlRA==
X-Gm-Message-State: AOAM530L3pjNgtj7a9tCRowmPQUtcqryP/YcgykWaErdSIafsPycxmhs
        mEguN+sjyDZf0XG55BcX/nj6sQ==
X-Google-Smtp-Source: ABdhPJxgKd0grAVZubtauNeLr0gM6zjTT0NhYAVYAbKmeUS7cPHPdkTquLwAiPqv/feLDELbuUEm/Q==
X-Received: by 2002:a65:6912:0:b0:3fc:907b:e05 with SMTP id s18-20020a656912000000b003fc907b0e05mr27657009pgq.414.1654656324473;
        Tue, 07 Jun 2022 19:45:24 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:463d:a192:6128:66e])
        by smtp.gmail.com with ESMTPSA id c140-20020a624e92000000b005182e39038csm11078266pfb.38.2022.06.07.19.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 19:45:24 -0700 (PDT)
Date:   Wed, 8 Jun 2022 11:45:19 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        regressions@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Nitin Gupta <ngupta@vflare.org>
Subject: Re: qemu-arm: zram: mkfs.ext4 : Unable to handle kernel NULL pointer
 dereference at virtual address 00000140
Message-ID: <YqANP1K/6oRNCUKZ@google.com>
References: <CA+G9fYtVOfWWpx96fa3zzKzBPKiNu1w3FOD4j++G8MOG3Vs0EA@mail.gmail.com>
 <Yp47DODPCz0kNgE8@google.com>
 <CA+G9fYsjn0zySHU4YYNJWAgkABuJuKtHty7ELHmN-+30VYgCDA@mail.gmail.com>
 <Yp/kpPA7GdbArXDo@google.com>
 <YqAL+HeZDk5Wug28@google.com>
 <YqAMmTiwcyS3Ttla@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqAMmTiwcyS3Ttla@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On (22/06/08 11:42), Sergey Senozhatsky wrote:
> > This looks like a NULL lock->name dereference in lockdep. I suspect
> > that somehow local_lock doesn't get .dep_map initialized. Maybe running
> > the kernel with CONFIG_DEBUG_LOCK_ALLOC would help us? Naresh, can you
> > help us with this?
> 
> Hmm, actually, hold on. mapping_area is per-CPU, so what happens if CPU
> get offlined and onlined again? I don't see us re-initializing mapping_area
> local_lock_init(&zs_map_area.lock) and so on.

Something like this?

---

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 9152fbde33b5..ea434a5226a3 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1104,6 +1104,8 @@ static struct zspage *find_get_zspage(struct size_class *class)
 
 static inline int __zs_cpu_up(struct mapping_area *area)
 {
+	local_lock_init(&area->lock);
+
 	/*
 	 * Make sure we don't leak memory if a cpu UP notification
 	 * and zs_init() race and both call zs_cpu_up() on the same cpu
