Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C46F0FFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 03:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344643AbjD1B3W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Apr 2023 21:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344335AbjD1B3V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Apr 2023 21:29:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3EC2713
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Apr 2023 18:29:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a9290a6f96so456125ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Apr 2023 18:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682645360; x=1685237360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cDQryB2NkV6iOjfYv+oDQDtHOKarGgoQkHlUF2y61dM=;
        b=jgF8VM6nwW/wHzLI+NPkqovh9OvMp+9g2ZK71Vva5HYarKNRN9vjD9AjSXnBvksmtL
         tP+3OiB7iJgvULjxQsQArWySGAFJagWeSR9KC1lLr2DL08OuBvVIXGbCkkwJTMDIjxA9
         kAXOdLtzhHc/1DG5+kqVyZVeyJX3+OgBZ82jMq5R5/135yzNVXKdBg5hQWiDoiiUNL8s
         pVAAXGo8vMkciOa0Wa2S6ZWHmc5dzbkwRAKCR3OwlCiAkZLnu/FsUvCD5tpOctqCQD4h
         OFsSVnquIX5+SWdoiGq9FnVU0ufd8DmpuTUACjIuzFe4R7dRZsPqu0i22HvBavWcm1qo
         YnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682645360; x=1685237360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDQryB2NkV6iOjfYv+oDQDtHOKarGgoQkHlUF2y61dM=;
        b=Ib2E9OVnr2pkN5JVWv6AP4s0PTwUiWayFjar5yg9iM/h6e+tEIMLZckUizeD9LRUlp
         Zu7VGQeMfDUWXakYiB4KjzehkpfggvmZrB3y8/Ku7O5M0d3FbKl9pSPyljjS7G1E2o2u
         tDvzRQyxzEmIs30e++HhgVmtV5fokThX1WtEXW3i6t6AMX7JB2JFD/VXrk2xuW7CZ0CT
         fGbTaPQPAA7O4ySsqa/i86Io6tsG2vspj943oUCymNeeyKaNhlGrddLp/PlcBMYVZkYI
         SBXiHn/54ONucd4hsuMfPvxtoIco46t1NH49V4Of0yLyUs80dnpG2ZJzxTYiXSruBNPp
         Q4yA==
X-Gm-Message-State: AC+VfDw5em5AhbciTcDMf3Pv0en2dTCl0u+/f1AU88SHm0QSsuweGm1e
        PLz53Yi4SyyZDKVS/xwT3Jv9NyyDoOh+9OY/JK69xA==
X-Google-Smtp-Source: ACHHUZ7S3SgdNPPYby223Abz3M3r/m16fAwU7XDht72rGOUuyOcox1wByB6KpOCCrZg8phPTxeoazzlCo4FoIYmj+GY=
X-Received: by 2002:a17:902:cec4:b0:1a1:c3bf:810b with SMTP id
 d4-20020a170902cec400b001a1c3bf810bmr136641plg.6.1682645360176; Thu, 27 Apr
 2023 18:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230413034108.1902712-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAAH4kHaBLvxLF+9CmAsLdVYtDM5SVzra2PVMu94v0ydRp3fiSQ@mail.gmail.com> <35a7839d-b970-fbe6-3dff-7774255dda62@linux.intel.com>
In-Reply-To: <35a7839d-b970-fbe6-3dff-7774255dda62@linux.intel.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Thu, 27 Apr 2023 18:29:07 -0700
Message-ID: <CAAH4kHbRmeK3SuEeryWnaU_daFcqPF==gU0H=fneJ2q9OmdG0g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] virt: tdx-guest: Add Quote generation support
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>
> How about the following?
>
> Although this method reserves a fixed chunk of memory for GetQuote
> requests, such one-time allocation is preferable to the alternative
> choice of repeatedly allocating/freeing the shared buffer in the
> TDX_CMD_GET_QUOTE IOCTL handler, which will damage the direct map (because
> the sharing/unsharing process modifies the direct map). This allocation
> model is similar to that used by the AMD SEV guest driver.
>
>

Yes, this is clear, thank you.


-- 
-Dionna Glaze, PhD (she/her)
