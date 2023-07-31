Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85CD76A4F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 01:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjGaXmz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 19:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjGaXmy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 19:42:54 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CE01B7;
        Mon, 31 Jul 2023 16:42:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b9cdef8619so31610575ad.0;
        Mon, 31 Jul 2023 16:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690846973; x=1691451773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7hg3VxRoU08q5hPKNlW6YF7vv+fBSVfAKzSjCaYJbQ=;
        b=Czs/46fAFXwgUSVna61zgI+/AxchGe8XwfL1ggFEGfpPl2ji9b6lPJk7MbHlHPha1i
         bR/0MaWtAeYrdIpEYKXnBVuIpkC8+faTzzvGpr2m1/IL5Twp3uFyKcpqWvyCC86GOp/w
         W2rnvx24/yGHM9uQmVmN1hPNRNBKX9nPGUY0I+NI/87ViXCISG0j5NeEw5OySKCgmqzu
         fpPFT1FXlu9DwCY22hs9ZVE2X9oPaKnYxyErsmZI4KaiVQdU5QY9qFTOdZCGK8OethMX
         UA5zTWztIddDPYXoWBi+LYrrwEEzI4lvioY9AQ0TlhUJgZQzIpo3NB5EKNmC+VTYrntA
         YXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690846973; x=1691451773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7hg3VxRoU08q5hPKNlW6YF7vv+fBSVfAKzSjCaYJbQ=;
        b=irmeWQ/iCF8fhCSg9Llcdsgd5fljIM1Ppbk8UAnZ0amDi/eB/D1rVuS9bzFkcujboZ
         FIFcu4SCUCuW6ujnlqp8MFH+/TdyHJKkgR2GIEJwL8oYmGIkqulRd6PdUv/9Cz9YIN8D
         iR/Yya+zOC8IjR74COGPOlTkJEQqwmDY/YzwgdRgLU3NMUprWQPvC44yeFe0RjiOR6Wl
         LNt9tyK+SzRPFWchK26HJZyDWQlnsDw0yMbM/5ndjciWSuvE+QaQQptu2zUspmsqp4yL
         zLQFJL1nWkX/TlEIBG1wTVtGvzxV2YgyMeUPXdGJ0+LaJ4Sw3fQC3J20qQwHNK2SduVc
         +IHQ==
X-Gm-Message-State: ABy/qLbsSmTg58g6Me2yr3yQTipNqTf6LdN/HWvKucDxJV8Mg5FQHfUM
        zxUtrVPUGvJI1KxYK3yZwOA=
X-Google-Smtp-Source: APBJJlHZfx4s7hLvMz95H3XgsYXWUfqcBomvD8eyg5YnYz3Kwcc7hdNGPxAKY5RoDU0aGIXkGMz2aw==
X-Received: by 2002:a17:902:ba95:b0:1b8:76ce:9dab with SMTP id k21-20020a170902ba9500b001b876ce9dabmr10508590pls.41.1690846972796;
        Mon, 31 Jul 2023 16:42:52 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4a3a])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090274c800b001b39ffff838sm9075022plt.25.2023.07.31.16.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 16:42:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Jul 2023 13:42:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, shuah@kernel.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next] selftests: cgroup: Remove redundant if statements
Message-ID: <ZMhG-yPZttsOY7y9@slm.duckdns.org>
References: <20230731134205.2723657-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731134205.2723657-1-lizetao1@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 09:42:05PM +0800, Li Zetao wrote:
> There is a warning reported by coccinelle:
> 
> ./tools/testing/selftests/cgroup/test_zswap.c:211:6-18: WARNING:
> 		Unsigned expression compared with zero: stored_pages     <     0
> 
> The type of "stored_pages" is size_t, which always be an unsigned type,
> so it is impossible less than zero. Drop the if statements to silence
> the warning.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Looks fine to me but the zswap test addition is going through akpm's tree, I
think, so probably best to repost it to Andrew.

Thanks.

-- 
tejun
