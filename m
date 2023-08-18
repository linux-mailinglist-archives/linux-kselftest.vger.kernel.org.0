Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7795F780F54
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 17:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357559AbjHRPg6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 11:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378219AbjHRPg1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 11:36:27 -0400
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59B22D67;
        Fri, 18 Aug 2023 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692372979;
        bh=bvV/soH/dURAAoXFyESTSqw98tSL2GFyxRs8zFGxUJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DxD5J40CRdyLoMBfh0M+ubUiB3R8L8QvLnblpeA3l9qVKvKQQux/PeKKyKRDATqlW
         Y9DQJ7nKSUo8Oefede7NfBrQdWHSzj3421zVpz1TjNv81OUJiktCR0t2FBk7Z4HI0/
         cPc93ROgyWX8/hMzY17lJFaKxkXLWBV991Xwiww0=
Received: from rtoax.. ([124.126.138.8])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 90FACE53; Fri, 18 Aug 2023 23:36:15 +0800
X-QQ-mid: xmsmtpt1692372975tun35vlo9
Message-ID: <tencent_6F0CBE858CB29E2E63544C5FF7461710E909@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85No3saEAZZsHGvRz8jNYaOJFWRAqomTdpjFsYYM/FhW1//BsolyPr
         kgMCXoM7zOoqq3pTlN2Z5iOpBFeZv+BkhHDNY/aQz8SdNiaM3GyO/38lx5zCCjYTCNDE+iJOb+Ht
         JBXScXJveNAq4YbMfPK+lTC2SpB1XAcnqqCDLIkxewjwXdrW0XP2QVhft3fyPnP+NktSyf3b2CN4
         RohO8GGFopAus8lsmeKiRuyQmG+kdxZYshXCMhFxWTK95PtFsoImGbsgGRf43Sk6WfpXKLWbrXO3
         nbhsQbHvzBvSWla7iY5SdpEGNsAADZo/WXG02oSlYaJPSYNJk96s3WVBHZNKxa0wWauK+rFi/ibD
         uePZjTWL22WCodBBcsAn883sGkAXIz3fyczacgQPcQ6hdN9w9Wny65bKvUI83qqZz5Rj2RU6ANhk
         9760mfwwZan4ouLrtLjlX2oeJKrdmydBqw5YjSIJzUrVkM8PR/JmXVmbZef+I2+zRTQU4Ne67Pru
         AYDxPDpcGF1zt2G9T77XIUaCB50a4UwTGBB9KNL+RbHGrUPtWfZ2MIaEbLZQLhz1FcoC/xDLyvWJ
         1atmEi8PGFcfJKxaaS7K8smI3eshSv8KYTrvxJo5YPT0H3zNB/3wtv4iMjHEyG80bRLC1FaI1Kor
         REsmOmxrKBNBiKTGn427yE1k+8752Z+1QFOwP5/4+mqk17EDL6uLJj36dMWTPw9NsoLGSHN+JJqD
         BzNFhajZWyA0HEKpAe/z6kKmEOMUm2ynYtwHDO/GoGuVswd+xMI0yEJ3bsxArH8cTSAUfsv8dZti
         woCleRIArFYWUUSNvOAXF6K0fmgLGEqEVWoVVnzaCInyRJ54lhVeQdoZTziHymRv2ufmmbYzSUAi
         UxZGhSPecGIzCT5IWpl/hkJk9YYnB50cmOlVMxJcrVR4XVEDvExs5dLwfWkVf+EL5Lr9HCrPrEEn
         qPo9QPO+l632JqqFTO1InRhzZxdganQ1O8HRvEagKV3eqjDv3Lj8Mn7zzqEI7Sz7Mo15nc6/UupK
         I3Z9xZ9A==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
Date:   Fri, 18 Aug 2023 23:36:13 +0800
X-OQ-MSGID: <20230818153615.46450-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZN9iDSj3/vdk5pRX@krava>
References: <ZN9iDSj3/vdk5pRX@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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

Hi, jirka

Sadly, we can't include libbpf_internal.h in trace_helpers.{h,c}.
we only have the following headers when compile samples/bpf/:

tree of samples/bpf/libbpf/
    +-- bpf_helper_defs.h
    +-- include
    |   '-- bpf
    |       +-- bpf_core_read.h
    |       +-- bpf_endian.h
    |       +-- bpf.h
    |       +-- bpf_helper_defs.h
    |       +-- bpf_helpers.h
    |       +-- bpf_tracing.h
    |       +-- btf.h
    |       +-- libbpf_common.h
    |       +-- libbpf.h
    |       +-- libbpf_legacy.h
    |       +-- libbpf_version.h
    |       +-- skel_internal.h
    |       '-- usdt.bpf.h
    +-- libbpf.a

No libbpf_internal.h here.

What if we add a declaration to libbpf_ensure_mem() in trace_helpers.c?

Good Day,
Rong Tao

