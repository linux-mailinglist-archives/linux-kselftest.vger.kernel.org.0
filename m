Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CDE77F013
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 07:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347802AbjHQFHv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 01:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348065AbjHQFH3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 01:07:29 -0400
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A14F1BF8;
        Wed, 16 Aug 2023 22:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692248840;
        bh=qL19K6EJ7u+hGNF667ktlTV7VvwidaQUhPnALBxEre0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hRICxlxOIzFYsCxYsIGwRuPfOlsu9Wr15FCV/Udz7Hh+9ZQVlTrDgj39SIacEf8za
         ewTmKifgWKgs1gP87qLsyyLRyxumLoOPknhC/WT4SGt0TnHnUzDA5gU2FCrp7PYCdL
         PjVz0Ub8PrVy0gBDjhD19C6JsMQjHSZC9J2XoEH0=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 1CFA1469; Thu, 17 Aug 2023 13:07:15 +0800
X-QQ-mid: xmsmtpt1692248835tz3oa29eo
Message-ID: <tencent_0ACEA803629581931054D6E3659F8AD3AB06@qq.com>
X-QQ-XMAILINFO: NSObNE1Kae7Zzzod1N7QKTYNY+acjUKzl/06K2ncS8K9y33OXGlwGpesmfitya
         fSTt9mo0rUhxYbz/Au9OXBfkXe/xfLZb5GPpgldINm5LO1iuVOPsKKht+xH5c0rQUChUb1mAecKB
         DjBTNiqPt9G9FYWCIaZF4YGNRmOn1h76R6YseHJaKyaeFdCqobb3yTZB3yyzqAsX/bmqARmu+7cI
         HQEO31REvPx3vMb4QlegZ9yOlqBk7pBoPp/h9te572no/iZX8ukUPb1xyc1gAaXRfhjMBvxjhpgh
         GJuer6P3FMMi5aEp1dJObM1cfOwaJM2Rs+3jHqaVP7gUc4inQ5mcqEJnoUGa6lO1eUQQxpkHMmCT
         OTR3JIjMnU3SNLVAUuHHNQ3zyHWUUSNPQXi7m1IDPe6cDlNutR3dl8tz66FC9WfJ0i0vptDGCGeA
         oK+vvn+3y9mDweZWYsR/zpnaQ6Kz1DRKczjOe1yNXELPgtFe4ZsgL2abUnKw3C3ZQxMUE+9XOpWQ
         p4O55rQ8lj3GY+VSUXstAEZlPCEPRtQ3JQ5OE3Mlz8bgkUmQhmJVNHqj0e9fHTUnUhllLZ3frepD
         okhOaNboqq9tGpocygLN1uqkN2KJzrasSG59s+lczfFStr6UxSA3I+jruCuzD/uXj67bndAnA8/H
         +6IcnMsyzS/df6/B5XRtg+XZxd0Qj5FtYqCAEr8+RytEc02ETSiZVzcO3c+jt6XAxn6R0z1B4Ahh
         0ByNOsjDxojPJKrkXfnyUUlr1kLEKa2xph27i+p+0S+4QiT3eGc1XDb6hxM+v0cdW75/O9z2edVJ
         5GIre+3bCXhXzENe3kIUi+KgvvBOJdCW+aU6WN0QaxoP3kfog9hdolo2Qz3ZW7euh15Cp9FulrmZ
         D+C2gOOvTmHilNkCCTvtgeJ97xNRA6cO5AduL2LjC4nNym9NB204vblQ46CyJHyvvjNMcAqv3ZP6
         ikglpHVSum+Aj7vLxO0byuTlWndBiFlx5TuQaoQdHb6Dw+x/tHZDIcbSxYVCSQPFcAinfk6SA=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From:   Rong Tao <rtoax@foxmail.com>
To:     daniel@iogearbox.net
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, shuah@kernel.org, song@kernel.org,
        yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v4] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Thu, 17 Aug 2023 13:07:15 +0800
X-OQ-MSGID: <20230817050715.20226-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <60da4749-3009-0e40-90bd-90cd03395e45@iogearbox.net>
References: <60da4749-3009-0e40-90bd-90cd03395e45@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks, Daniel

I just add ksyms__free() function, it is called when ksyms__add_symbol() fails.

Good Day,
Rong Tao

