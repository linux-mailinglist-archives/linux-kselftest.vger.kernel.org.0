Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2596551CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 16:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbiLWPCm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Dec 2022 10:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbiLWPCl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Dec 2022 10:02:41 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35FF23E9E
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Dec 2022 07:02:40 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id l10so5179236plb.8
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Dec 2022 07:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hym9I/8Zx2heqtzvbjDG8T0F+0F1WrxSB82+3fgXrCs=;
        b=RkCDOqxRJ5Xj+NtiaIuQ7fE0ZtalDZpwA/P+90rf5TxBXdVQ443U5LuxQLa9Tm/iJR
         D9+DuWqGVaV85SXh7UOEIQqZgr2KHx5o/sV6sXxpfT1o0iGRqjGE42Ojx2a6zsOF9nAX
         ZCWcdCbbLudnqN/jTnwkQFRzR4UiohqVkiiBkoesaQ/2+N+tZYqORIU239tmSqGQzZlG
         I5zWinTF/XhOZOTYXqVRVxrNGNR1ONpTXfaUWaSSKoIsAG/U7WQCfm1F0saKWyYo1ytZ
         1Vg9kpU1Jun115p3Nk0259QS97eHycTJta0AofuqIzWsclScrcV6zBjVABn8EeTmNImK
         vqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hym9I/8Zx2heqtzvbjDG8T0F+0F1WrxSB82+3fgXrCs=;
        b=fQxAVKGFxBDY62tQJl56b9ImvY/bbFAWKFSsFq3qBTuDR6IO44y37oCU5sYoLP/HcA
         uoVnc11Zl0bFKzS8YVJl/HQVoWsVnTs9cKfLf+zyuWs/itrnbH31IWodsvHTIuVsCc45
         H8I0KHeCxfHxIhzTBVMTeHR1WEUDFKdhBysC/rvjZjhbNgzV04wthuFnuyY5p3EhgDFI
         ZxlQUU8WYFJIXOHjU7IuUjf9jniq13jFMgP2BSxoxSIUqbRt/CEPFxJqpSKter60J5GA
         WzChHIgUcV6IHgIo4EsMN41PQLyGe/gTZe/SPSKwglWr7nl2Id1uV4keWE2w7mWImnr0
         43Cg==
X-Gm-Message-State: AFqh2kpM8V3zIegk3hkFTqHCVRMgj/EbauEHgp3FvKVU/Nfo3FZCJwcj
        7mytWXSrSZGG1MS+o7t+uifb
X-Google-Smtp-Source: AMrXdXtsYyuhBmpwbDlQIl+Ry+zm4L2NR4g7iB8qu6wucOubA3roxo2rzNv7BgX/Hpk+rfDsHjmOOA==
X-Received: by 2002:a17:90a:ce8c:b0:223:f6c2:f21a with SMTP id g12-20020a17090ace8c00b00223f6c2f21amr10749315pju.35.1671807760314;
        Fri, 23 Dec 2022 07:02:40 -0800 (PST)
Received: from thinkpad ([27.111.75.82])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a034300b002191e769546sm2373891pjf.4.2022.12.23.07.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 07:02:39 -0800 (PST)
Date:   Fri, 23 Dec 2022 20:32:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Aman Gupta <aman1.gupta@samsung.com>, shradha.t@samsung.com,
        pankaj.dubey@samsung.com, kishon@ti.com, lpieralisi@kernel.org,
        kw@linux.com, shuah@kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: Re: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Message-ID: <20221223150211.GC4587@thinkpad>
References: <CGME20221007053726epcas5p357c35abb79327fee6327bc6493e0178c@epcas5p3.samsung.com>
 <20221007053934.5188-1-aman1.gupta@samsung.com>
 <641d1e50-a9d0-dc15-be76-07b8ace25dae@linuxfoundation.org>
 <20221222174532.GA59500@thinkpad>
 <b2a5db97-dc59-33ab-71cd-f591e0b1b34d@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2a5db97-dc59-33ab-71cd-f591e0b1b34d@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 22, 2022 at 10:49:48AM -0700, Shuah Khan wrote:
> On 12/22/22 10:45, Manivannan Sadhasivam wrote:
> > On Thu, Dec 22, 2022 at 09:58:30AM -0700, Shuah Khan wrote:
> > > On 10/6/22 23:39, Aman Gupta wrote:
> > > > This patch enables the support to perform selftest on PCIe endpoint
> > > > driver present in the system. The following tests are currently
> > > > performed by the selftest utility
> > > > 
> > > > 1. BAR Tests (BAR0 to BAR5)
> > > > 2. MSI Interrupt Tests (MSI1 to MSI32)
> > > > 3. Read Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > 4. Write Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > 5. Copy Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > > > 
> > > > Signed-off-by: Aman Gupta <aman1.gupta@samsung.com>
> > > > Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> > > 
> > > Adding Bjorn Helgaas to the thread.
> > > 
> > > Adding pcit test under selftests is good. There is another pcitest
> > > under tools/pci. I would like to see if the existing code in
> > > tools/pci/pcitest.c can be leveraged.
> > > 
> > > As part of this test work, also look into removing tools/pci so
> > > we don't have to maintain duplicate code in two places.
> > > 
> > 
> > It has been agreed in a thread with Greg [1] to {re}move the tests under
> > tools/pci and utilize the kselftest.
> > 
> 
> Inline with what I am suggesting. However, I don't see either move or
> delete of tools/pci in the patch?
> 
> The first patch could start with git mv of the existing files and then
> make changes to preserver the history.
> 

Right. This patch was posted independently of the series [1] that I submitted to
fix the return values of IOCTL calls used in drivers/misc/pci_endpoint_test.c
driver.

Then in that series, it was decided to move the existing test to kselftest. So,
I suggested Aman Gupta [2] to integrate my latest patches, add the kselftest
patch on top, then remove the existing test under tools/pci.

The kselftest patch can also move the driver first and then make the change as
you suggested. Either way it is fine by me.

Thanks,
Mani

[1] https://lore.kernel.org/lkml/20220824123010.51763-1-manivannan.sadhasivam@linaro.org/
[2] https://lore.kernel.org/linux-pci/20221221072423.GC2922@thinkpad/ 

> > 
> > [1] https://lore.kernel.org/lkml/Y2FTWLw0tKuZ9Cdl@kroah.com/
> > 
> 
> thanks,
> -- Shuah
> 

-- 
மணிவண்ணன் சதாசிவம்
