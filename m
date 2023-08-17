Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B3F77FE11
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 20:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354518AbjHQSod (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 14:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354616AbjHQSob (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 14:44:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A85D2D59;
        Thu, 17 Aug 2023 11:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=s+yMCPhjOL7dlSQxxy56NPES58qbEzmGhM9FA47BA0A=; b=Qhnpe5SeMJkLfyfzpBPvYDPI3R
        j4P85C4Uh4ATWL6Qq1ONYids/qrE8DOZasKvViv0jyxEQbwpZir0Hh4l6jtLAIp6gXzVIXmDT6SMv
        Tc6Rc9QiP2qmdoOE21PNA7mCn9O2oj32s4xmFtpj8bh6J/6y+sHNvV0WaZSAIJdBVzM6jB7ETjlmW
        Jkxg+4/TUq8LxBCINDUk1fiBOk9CY8pqYN2xKyc5JeWUbzGROI//o3ZUAIW41v5BQZTEbrPexe4tB
        uryMhitBnum3WIHq6pdDOhbiix7W+6C2XiOCMsSDMv2BIgECJ0gsPDn3WW+YAELEepiYWi5DRCnUy
        pVLPNISw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qWhyt-006ztU-1Q;
        Thu, 17 Aug 2023 18:44:27 +0000
Message-ID: <17065c3f-87bb-c2a9-e8f6-82fecd15b9c7@infradead.org>
Date:   Thu, 17 Aug 2023 11:44:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: linux-next: Tree for Aug 17 (DRM_TTM KUNIT tests)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>
References: <20230817144729.7d2b1b53@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230817144729.7d2b1b53@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/16/23 21:47, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230816:
> 

on risc-v 32-bit:
when
# CONFIG_MMU is not set


WARNING: unmet direct dependencies detected for DRM_TTM
  Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && MMU [=n]
  Selected by [y]:
  - DRM_TTM_KUNIT_TEST [=y] && HAS_IOMEM [=y] && DRM [=y] && KUNIT [=y]

WARNING: unmet direct dependencies detected for DRM_TTM
  Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && MMU [=n]
  Selected by [y]:
  - DRM_TTM_KUNIT_TEST [=y] && HAS_IOMEM [=y] && DRM [=y] && KUNIT [=y]

WARNING: unmet direct dependencies detected for DRM_TTM
  Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && MMU [=n]
  Selected by [y]:
  - DRM_TTM_KUNIT_TEST [=y] && HAS_IOMEM [=y] && DRM [=y] && KUNIT [=y]

/opt/crosstool/gcc-13.1.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: drivers/gpu/drm/ttm/ttm_bo_vm.o: in function `.L31':
ttm_bo_vm.c:(.text+0x42c): undefined reference to `vmf_insert_pfn_prot'
/opt/crosstool/gcc-13.1.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: drivers/gpu/drm/ttm/ttm_bo_vm.o: in function `.L104':
ttm_bo_vm.c:(.text+0xa70): undefined reference to `vmf_insert_pfn_prot'


-- 
~Randy
