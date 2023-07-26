Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4047A763F10
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 20:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjGZSzL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 14:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjGZSzF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 14:55:05 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B141710;
        Wed, 26 Jul 2023 11:55:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686efa1804eso126890b3a.3;
        Wed, 26 Jul 2023 11:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690397704; x=1691002504;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BOTKnXna4UBmSzaquK4MpM5+JZhCMZ29vmnMmyhOwAQ=;
        b=V9m6jzugaQTQBRzNsM3A4pS4ahZgjq1WhYSN0nuA067Mu7+yqGOymPT9iLDUJ5QZ/P
         qOL0j0ltHRCFW2SnQUWR3mctQqUvk5DpXXjDSE+XDaJ7qi+QluUHYuUBdBhDyqCXUPPF
         i21hR3ywZI1XyQ5m9qLl3r3ZMVs1iy+su3FRN2eFXm92f00WmQ3OIQyxUN8sBq3nDV3Q
         cYY/p8VmzynSCf5TXJrIMoWeV5OD2ELYidQDAhPCJGlPTo2VElJsEAY/i+UiaPysw1Es
         eE7OxAkjnBSV+n9iNn8oWZ+Cva2Hfk3aVXH49hVuWojjTukLBRtNQTM2qaWFWb/R7BzN
         gC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690397704; x=1691002504;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOTKnXna4UBmSzaquK4MpM5+JZhCMZ29vmnMmyhOwAQ=;
        b=axYM5UjMHWWgYkI4PAaaOonen0Jx1Zldz7wKITA78/buh1GOykTN2mBwewLgSY/e94
         ea3nWE0u88tAxaLYYtJI6/TlryN73VuYKcinr1ylyH3GwzAj8/Xs7NEB6osfNvaC18P7
         bu1DmrLcWCgfYRGHAccfgX651Xe8UDhNUHqeNxJuMjVvMrAR4IW0r1VSZD3cZNwqlNqm
         OUutSVK8wbKSKstkj+yk4E47+WdXAtQ8O57Pm9bus8CfmXxE4RwFfmjN9vzO8lAJo/fM
         2We3YyUud4nqQ8tFv5cvv+i2nQSuIi6gs/Wh3xJ9YAsEuxOQB+S2PATSomppHrPiz/NI
         0iUA==
X-Gm-Message-State: ABy/qLbpcr/0DDlOCuWmKO7paX49KxXJDxqRwIe63HbwDXWC0Y4BqHd4
        yQm3yQpdav5xct/w9m8fO2k=
X-Google-Smtp-Source: APBJJlEY854z5gql9DKgOvy9DywF7XoBIv4g96JJV5lNMjgThpHH0muRUlZU50y+IuVuH+QGWf24yg==
X-Received: by 2002:a05:6a00:21cf:b0:682:713e:e520 with SMTP id t15-20020a056a0021cf00b00682713ee520mr3158966pfj.8.1690397704495;
        Wed, 26 Jul 2023 11:55:04 -0700 (PDT)
Received: from localhost ([192.55.54.50])
        by smtp.gmail.com with ESMTPSA id fe18-20020a056a002f1200b00686dd062207sm1555259pfb.150.2023.07.26.11.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 11:55:03 -0700 (PDT)
Date:   Wed, 26 Jul 2023 11:55:02 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Ryan Afranji <afranji@google.com>
Cc:     linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        seanjc@google.com, isaku.yamahata@intel.com, sagis@google.com,
        erdemaktas@google.com, runanwang@google.com, shuah@kernel.org,
        drjones@redhat.com, maz@kernel.org, bgardon@google.com,
        jmattson@google.com, dmatlack@google.com, peterx@redhat.com,
        oupton@google.com, ricarkol@google.com, yang.zhong@intel.com,
        wei.w.wang@intel.com, xiaoyao.li@intel.com, pgonda@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, ackerleytng@google.com,
        isaku.yamahata@gmail.com
Subject: Re: [PATCH v4 00/28] TDX KVM selftests
Message-ID: <20230726185502.GA1686573@ls.amr.corp.intel.com>
References: <20230725220132.2310657-1-afranji@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 25, 2023 at 10:00:53PM +0000,
Ryan Afranji <afranji@google.com> wrote:

> Hello,
> 
> This is v4 of the patch series for TDX selftests.
> 
> It has been updated for Intel’s v14 of the TDX host patches which was
> proposed here:
> https://lore.kernel.org/lkml/cover.1685333727.git.isaku.yamahata@intel.com/
> 
> The tree can be found at:
> https://github.com/googleprodkernel/linux-cc/tree/tdx-selftests-rfc-v4
> 
> Changes from RFC v3:
> 
> In v14, TDX can only run with UPM enabled so the necessary changes were
> made to handle that.

Thank you for updates. Let me give it try for v15 TDX KVM patch series.

-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
