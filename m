Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CB8783718
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 02:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjHVApk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 20:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjHVApj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 20:45:39 -0400
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF724137;
        Mon, 21 Aug 2023 17:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692665133;
        bh=U/NjBqs1v8LFkNfFExolNi+HeBdE24Ij+M+rdN9VbHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Nle3/jj13wDafXCbcjwi65KkbMrj7dtxUsaqbZ64X4wYWymBcTSdVVy/Lamvqaz2s
         9BFWE4wMU/AoRzddtDBVLxL1u5TMPnZraecY6ZLSi3U4Pm2mOziSqCIALN0AP6amuk
         G77CeOfdO4GehWAEqk6VeXXp05YoAoLf0t8pYKXU=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 9BA2F6C7; Tue, 22 Aug 2023 08:38:58 +0800
X-QQ-mid: xmsmtpt1692664738tvyavmkzo
Message-ID: <tencent_492BE2E81E62BEC199106096C025954AFD06@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9EFx0+urXeihKshPwb5GrYYB+ECcAcv/KXsvNg/P9b8hPQP7Tqe
         jU42kfKPnw4EOYlj4iw22YwDEIu5qrsFljhh+YiMFIe0Y+3QoCDclpXcLn0OiYM44zF1IRrGqOFF
         R2K2P2ERPW0uWKJcTvmnWk4zJ+AHoMejKj3YJq/Ao7B53Qc1IpLnVA+Sql+rcQt/9UWSTaljz/Ou
         BLtzYSrP1xqBlDQ+XgSZqvZeSpGtudlKwgK7thyMEjkLDiWsP4AkEsMpfAlZLg6D+KqS/+xqxoSZ
         YiMrzivgyNVF4hhW/zLx7BPg7e6WReO0NNG5gp1KFcWVHxVWQWQ2n05uZJ0DM5+5hskZT6rCUGEn
         cjD0/ChAusmG02ULDOO5hR48FrGNXlHrFTnKo8h9jBiQGHbRyDYjs8N7U6hHzBrQRJOQ/U+oDSG3
         mxpGGUkHE/xRvdMWylqsjWbza8oYL1f5vzYQ5pRBdDlbuMfIDBh3wNfrEQEIA2ZbmZXCvRYf6Bdc
         Myd2625ylY3HHKyZfIVQf0ahQuxRR705dmyVSa0iOlFYikX27s0scVplLE/+4JpsGutN/Tl0ilAL
         g71QvgebjOYPjL2aJk9PQLZIunJcGleLUxQQwAW4yd82oF9gPrejz1L+opkpXOJ52ouPEnDKrn45
         mBo/5IA9YE3YE5OaM5ClNA5IF4Oy26RP+KfNHFNyX+Pl11v4XA01H+Ye7xMsiFQtDuVpwuY1dFB7
         bosjyFPU7ImDYcv0mA4L5l60HH5N3NsAPPArrWB4nvlsbHW1SN6CbUmgt5TENoHSCZf7WxYXp16t
         mgoBgY1r26cn7FIKQ3CkzQODnL6EtUCyhEjkP4F0dgi3KCIwoTuV1zA+bX8nJ3+N/MoWv6Y0uchG
         W0jSFf5Ym56Ym8f8yG3VUiDwRSewmM/k1LwD9xny3Yx0qZ4CQJER8g7qaoB1B4C3/Fy4s61/KbIY
         btyIOrL284GrrUjkPVW1/vpK3WX9SHSfTalCix2GLmg2ejmwTx6jvV9nF/8HNtBKgr+bwBirs=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From:   Rong Tao <rtoax@foxmail.com>
To:     olsajiri@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, shuah@kernel.org, song@kernel.org,
        yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v6] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Tue, 22 Aug 2023 08:38:58 +0800
X-OQ-MSGID: <20230822003858.8886-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZOMiqE0QY2Lrw2UC@krava>
References: <ZOMiqE0QY2Lrw2UC@krava>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> I think you need to fix this on samples/bpf side
> 
> I tried to play with the samples/bpf/ includes, but couldn't find a way to
> make this work.. selftests base includes on tools/include, while samples
> have $(objtree)/usr/include as first include and AFAICS the __must_check is
> defined under __KERNEL__ ifdef
> 
> I guess the reason samples use $(objtree)/usr/include is to get some struct
> definitions which are not in tools/include, but looks like some samples objects
> already use vmlinux.h include, so that could be the way forward to fix that

I tried the method you suggested, and some unexpected problems occurred. Maybe,
we can apply v5 [0] first, and then solve this problem?

Best wishes,
Rong Tao

[0] v5: https://lore.kernel.org/lkml/tencent_0E9E1A1C0981678D5E7EA9E4BDBA8EE2200A@qq.com/

