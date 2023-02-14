Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11191695901
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 07:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBNGQx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 01:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBNGQw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 01:16:52 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6374611EB7
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 22:16:51 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v23so16026525plo.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 22:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nAySxquq1s3jzJAwcjF683sKayihoZDN4RvDCMUZnxk=;
        b=t9hnTuTMc0o0A48ejbMSJrJMrxV9zbsWWp+1cGI8A+Rn+XzXuBDSNmLJoTNDZOqY6t
         8raWs/9jDz9xEPeliZ8boknHo2Dt+FLWoXArj6sPXfaFgnbjNRXGRuqZOo5RQZhyal7Y
         qkqzhXL+oTzMIq51/wbuQw7ASvMjoPK8lQyxudgrN7orIlMVrH4jk36RwFbx9DHR1aQK
         Rrsdow7N/f5/7q29v3+i605yZPJmkqONBHva+S8XnhpJtojsF7Yk1ej55KwgO67w7dcN
         S9WuyEw3m4SUZSZ/DiHFSvey5GHaqzLiYjmsKMRQUtPXWncZTLNyjtS/o6Yl1Z3JmlUe
         qghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAySxquq1s3jzJAwcjF683sKayihoZDN4RvDCMUZnxk=;
        b=alXoCfW4ergr5chYpCGSgOUgm/jPo9YAJ7HFicbXVdFMerti3YEcRtK7ggnuF9Ly3m
         fn+1aJoa3Oe8d5yrjFn2tesp8Uxrkp8Ld61jUDmIXrgpx/ufvOVLdSLS8+wyX4RkZ51V
         UkFZWHhAieuJhKmJzrMR2vkw72nU08DTrb7dZc8oiWwPSO2LQo4b3wTtza1nEVUFUKTk
         q5l50BdCgNMWsxrSUDq/z1agt8oyFmG+izkAD0zzeO3eFY/Kmus7EvToXHFlGHqLrnzs
         yFZ1bbAfPhbqHL80dHShTp/hqn5EAYBBjAkZ7UgqeAjlLP54f6o5s0f8qOmXD/VchnKb
         9aaA==
X-Gm-Message-State: AO0yUKUGANtJI/Pk0gjdPp39L8DKE9JrOVfvmhXggl+5KNIImhWsYrAA
        8F3p81GAYv79mE9/x1zjaRSP
X-Google-Smtp-Source: AK7set9V9GcVet7QADdGuqEsRF0qBGSbEsRt+cuHuWHHlZ1mey0l95xHqFDVRrRIG6U+1+6TIyOueg==
X-Received: by 2002:a17:902:f30b:b0:196:8445:56be with SMTP id c11-20020a170902f30b00b00196844556bemr1057726ple.42.1676355410714;
        Mon, 13 Feb 2023 22:16:50 -0800 (PST)
Received: from thinkpad ([117.217.182.252])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709029a0c00b0019339f3368asm9322235plp.3.2023.02.13.22.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 22:16:50 -0800 (PST)
Date:   Tue, 14 Feb 2023 11:46:43 +0530
From:   'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
To:     Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics 
        <aman1.gupta@samsung.com>
Cc:     'Shuah Khan' <skhan@linuxfoundation.org>, shradha.t@samsung.com,
        pankaj.dubey@samsung.com, kishon@ti.com, lpieralisi@kernel.org,
        kw@linux.com, shuah@kernel.org,
        'Bjorn Helgaas' <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
        'Padmanabhan Rajanbabu' <p.rajanbabu@samsung.com>
Subject: Re: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Message-ID: <20230214061643.GA4981@thinkpad>
References: <CGME20221007053726epcas5p357c35abb79327fee6327bc6493e0178c@epcas5p3.samsung.com>
 <20221007053934.5188-1-aman1.gupta@samsung.com>
 <641d1e50-a9d0-dc15-be76-07b8ace25dae@linuxfoundation.org>
 <20221222174532.GA59500@thinkpad>
 <b2a5db97-dc59-33ab-71cd-f591e0b1b34d@linuxfoundation.org>
 <20221223150211.GC4587@thinkpad>
 <7dcefe25-d31c-bc26-4910-e53bed6eb01c@linuxfoundation.org>
 <003d01d919b2$3c7d54a0$b577fde0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <003d01d919b2$3c7d54a0$b577fde0$@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 27, 2022 at 10:45:26AM +0530, Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics wrote:
> 
> 
> > -----Original Message-----
> > From: Shuah Khan [mailto:skhan@linuxfoundation.org]
> > Sent: 23 December 2022 22:01
> > To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: Aman Gupta <aman1.gupta@samsung.com>; shradha.t@samsung.com;
> > pankaj.dubey@samsung.com; kishon@ti.com; lpieralisi@kernel.org;
> > kw@linux.com; shuah@kernel.org; Bjorn Helgaas <helgaas@kernel.org>;
> > linux-pci@vger.kernel.org; linux-kselftest@vger.kernel.org; Padmanabhan
> > Rajanbabu <p.rajanbabu@samsung.com>; Shuah Khan
> > <skhan@linuxfoundation.org>
> > Subject: Re: [PATCH] selftests: pci: pci-selftest: add support for PCI endpoint
> > driver test
> > 
> > On 12/23/22 08:02, Manivannan Sadhasivam wrote:
> > > On Thu, Dec 22, 2022 at 10:49:48AM -0700, Shuah Khan wrote:
> > >> On 12/22/22 10:45, Manivannan Sadhasivam wrote:
> > >>> On Thu, Dec 22, 2022 at 09:58:30AM -0700, Shuah Khan wrote:
> > >>>> On 10/6/22 23:39, Aman Gupta wrote:
> > >>>>> This patch enables the support to perform selftest on PCIe
> > >>>>> endpoint driver present in the system. The following tests are
> > >>>>> currently performed by the selftest utility
> > >>>>>
> > >>>>> 1. BAR Tests (BAR0 to BAR5)
> > >>>>> 2. MSI Interrupt Tests (MSI1 to MSI32) 3. Read Tests (For 1, 1024,
> > >>>>> 1025, 1024000, 1024001 Bytes) 4. Write Tests (For 1, 1024, 1025,
> > >>>>> 1024000, 1024001 Bytes) 5. Copy Tests (For 1, 1024, 1025, 1024000,
> > >>>>> 1024001 Bytes)
> > >>>>>
> > >>>>> Signed-off-by: Aman Gupta <aman1.gupta@samsung.com>
> > >>>>> Signed-off-by: Padmanabhan Rajanbabu
> > <p.rajanbabu@samsung.com>
> > >>>>
> > >>>> Adding Bjorn Helgaas to the thread.
> > >>>>
> > >>>> Adding pcit test under selftests is good. There is another pcitest
> > >>>> under tools/pci. I would like to see if the existing code in
> > >>>> tools/pci/pcitest.c can be leveraged.
> > >>>>
> > >>>> As part of this test work, also look into removing tools/pci so we
> > >>>> don't have to maintain duplicate code in two places.
> > >>>>
> > >>>
> > >>> It has been agreed in a thread with Greg [1] to {re}move the tests
> > >>> under tools/pci and utilize the kselftest.
> > >>>
> > >>
> > >> Inline with what I am suggesting. However, I don't see either move or
> > >> delete of tools/pci in the patch?
> > >>
> > >> The first patch could start with git mv of the existing files and
> > >> then make changes to preserver the history.
> > >>
> > >
> > > Right. This patch was posted independently of the series [1] that I
> > > submitted to fix the return values of IOCTL calls used in
> > > drivers/misc/pci_endpoint_test.c driver.
> > >
> > > Then in that series, it was decided to move the existing test to
> > > kselftest. So, I suggested Aman Gupta [2] to integrate my latest
> > > patches, add the kselftest patch on top, then remove the existing test
> > under tools/pci.
> > >
> > > The kselftest patch can also move the driver first and then make the
> > > change as you suggested. Either way it is fine by me.
> > >
> > 
> > As I mentioned in my previous email, I prefer to see the move as the first
> > patch and then changes on top. This preserves the history and cleaner.
> > 
> > thanks,
> > -- Shuah
> > 
> 
> Hi Shuah,
> 
> Thanks for review and suggestion. I understand that we would like to reuse and preserve the history of tools/pci/pcietest.c. So we have two approaches:
> 
> 1: Using git mv command move existing code from tools/pci/ to tools/testing/selftest/drivers/pci/ and then update the file to convert to kselftest framework. I thought about this but after movement, when we move it to kselftest format it is going to be huge churn and we will be having modification in almost all lines.
> 
> 2: Develop kselftest based driver in tools/testing/selftest/drivers/pci/ and eventually delete existing file from tools/pci/ folder providing justification in commit message.
> 
> From my viewpoint, going with the second approach makes more sense because if almost complete file is getting modified, and it will make the review process complex and anyways there is not much code reusability.  
> Please let me know if you have any other thought process or if I am missing anything to understand your approach.
> 

As Bjorn and Shuah said, I presume you are working on option 1.

Thanks,
Mani

> Thanks,
> Aman Gupta
> > 
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
