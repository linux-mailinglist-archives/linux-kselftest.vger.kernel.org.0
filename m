Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5929780373
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 03:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357032AbjHRBkN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 21:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357025AbjHRBjm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 21:39:42 -0400
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E891710C0;
        Thu, 17 Aug 2023 18:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692322778;
        bh=HwlS99rKftcCjJkXQ9IOansZ25GQOznIAvv1J4y70hI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kkaNflEGt8NtwbZU4Vw0fEJl0vhpLYkRj2wJpGo8p4kK7qQ8/tLrI/Wb/asq8EAGa
         X2i/q2/Wylf0B92x0ZolGjTmzI4dZyeKthktnxPiXz8mNv8UcWYrKBRUzY29rNQJWU
         kc6JA9Bj5+FGDkM2PbNgIXbaSMRfuX0r1hPJjC8Y=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 9E127C29; Fri, 18 Aug 2023 09:39:33 +0800
X-QQ-mid: xmsmtpt1692322773tmej5lrvm
Message-ID: <tencent_03EBFD524265EA7560341E91C5E04F083405@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeienvsCx/U4Ubq51UCVl4H8yRQHU4+1XdXbpolMYva+4SdxIGrXVm
         pNWR6MtgfmXzLxfX0bunLxwotPEUoYe+ISXLRYkzkzfOvdJBclhaEid8gi8lq5C9e/pjV28yBASx
         EO1T/3Q9WAMy0/ejsBJYW5K0MBcjtmDBiGE1NncJBlgk42PaD+TTPjv0n1m/QQilTOBOK7onok4l
         mP/QeSmwPzY77nocbyrC42ypP05GwLhxxfctR+dSZhrtnlAkR/ncEAqU88lCuOc69Sxyc4CdgwL7
         FGqrPUgmGVzkKlOBeebrfA1fl8gK1g4Ou6URChxGrXy8IMJQg4CvH2e8kyJn/2Y7dAtPPxZ2sNcq
         ZrsMWbF9vSFoLRt7x/cWJOX4idoIkk+TmKqKrz3m/la3jn+RqenwoNOEs3TbmaHZAcGObCM3ZRST
         IXbXJVtfy3cJzkKZC0X1/IzoZ3tzcHajAatZYkClOnZ2zicKRpaidYXGKTn9m/zUNQ4AZtkE9Vz5
         jf0IYgDBrDi/2090Qh+IMfUEbcuiiVTeae4dnnkIgIDFAS1BrmWffeBJXZ39nNep/f5IZWmEhRc9
         keChmtxmpcIgN06rx6M/e4WP5XzSnnzO/CFwzAZRs+ppko1AJaf/jalhwh18U4QbYq2zC3/4xonI
         aawpNWthuxt/8JQMIL0r1PrA2ZbYS/QZimt4QFYDcjOjF5pOBe1PBFul/lozO9D8p6xuJ2N9fnO1
         V5agwxDtETjQQ4SAf0MAmDB337kXMYTxIlR2XWctGr2TE/J7zZnmk+JyNyeMBTRpohPuqD/0m7k0
         0v/1FrkUz3CF34od41N07x1/BJtnVpmJ9X0+EjuifaCdIzvwJrhvyMNNOdrgGYSvwfGMw9iF4Rrg
         yt5RDU2hD8ENi2UJD0RRqva2s0xvXmitFEFkmi3L880KgO+8HAxTvaN3FB5C3XJOP40KTutBGSJn
         VPfxAc0JOVMuxvunJT5y4KOdfG9I+IhmeGmO1YD93wtlze7P84St0qM40zEy4Z
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From:   Rong Tao <rtoax@foxmail.com>
To:     olsajiri@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, shuah@kernel.org, song@kernel.org,
        yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v5] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Fri, 18 Aug 2023 09:39:32 +0800
X-OQ-MSGID: <20230818013932.22139-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZN3YeyMkgEg1IoKP@krava>
References: <ZN3YeyMkgEg1IoKP@krava>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Jiri. Thanks for your reply.

libbpf_ensure_mem() is in libbpf_internal.h, samples/bpf/ can't see it, do we
reposition the function declaration?

Good Day
Rong Tao

