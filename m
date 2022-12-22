Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9898C65456B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Dec 2022 17:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiLVQ6f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 11:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiLVQ6e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 11:58:34 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C086B15A3D
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 08:58:33 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id d14so1232583ilq.11
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 08:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSFXjoWtwnBi1YCgBNkvPzvy1204ExxRx5Br5L9WXvk=;
        b=OZlR/LevIjNdSzuBnMAiRvMJ5QDcLy4QB/ZNpwaA0VetIf2kMuSYT9f1I4GT3Ag8NT
         bJu10lAGBCOnK9SdCJI54ZLneqexvyzxEIdFRn1+bRDLAeYhGEzgZv57EdLNjMO27w33
         W27fGkdoVmZKdpL+lKiBq5uwZ6KFWEt6+WtL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSFXjoWtwnBi1YCgBNkvPzvy1204ExxRx5Br5L9WXvk=;
        b=Nic+164Cokr3Pr0AfvK3lwErthLX6eMyJOo2jGoHAnb5ZM3ikKmK+XrEsTpCE2pIyj
         NEKWiz0OMM2AV/dEaA3/jVppWrPRbLo01LwwbkzRQidMfqB+mVwBQT2ZjnSOwFy1EbjV
         0LMMCFfMr64pdXI7OzauyhK1MCmSmyjOlhrXGZrUDx9jGqdK92ks7RdII2FbyU9BtWvu
         IRP4TS7ZZa9Rrc4MiWuCJYJPUHXMOzl1BKeVcS/RLldQH75MXAeJ35T1/1V15Ngt64vL
         U9/V1NTqFX/ZZjtEV+k0MberLWEPUQtN5XB2uOaq9Omaw9qomNkjGssjHgaNsdZ0gBIE
         CcKA==
X-Gm-Message-State: AFqh2kq1z5NZyuCMxXeL2rT+epcocQbx3k8oVS1lFPBmRGIXqzLCE1lj
        85BdPG/zarrGf1hwUb3UrHl45g==
X-Google-Smtp-Source: AMrXdXsGXi8YHMjU+Yn6Whmi5DC7cWLuRQ5V7D1MYexq88w8oVPxr6Mul/NcH9nlBsUf2FCsPhJQnA==
X-Received: by 2002:a05:6e02:1244:b0:304:b2dc:4274 with SMTP id j4-20020a056e02124400b00304b2dc4274mr850849ilq.3.1671728313103;
        Thu, 22 Dec 2022 08:58:33 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c17-20020a92dc91000000b00302f4f69f62sm368590iln.12.2022.12.22.08.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 08:58:31 -0800 (PST)
Message-ID: <641d1e50-a9d0-dc15-be76-07b8ace25dae@linuxfoundation.org>
Date:   Thu, 22 Dec 2022 09:58:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
To:     Aman Gupta <aman1.gupta@samsung.com>, shradha.t@samsung.com,
        pankaj.dubey@samsung.com, kishon@ti.com, lpieralisi@kernel.org,
        kw@linux.com, shuah@kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <CGME20221007053726epcas5p357c35abb79327fee6327bc6493e0178c@epcas5p3.samsung.com>
 <20221007053934.5188-1-aman1.gupta@samsung.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221007053934.5188-1-aman1.gupta@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/6/22 23:39, Aman Gupta wrote:
> This patch enables the support to perform selftest on PCIe endpoint
> driver present in the system. The following tests are currently
> performed by the selftest utility
> 
> 1. BAR Tests (BAR0 to BAR5)
> 2. MSI Interrupt Tests (MSI1 to MSI32)
> 3. Read Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> 4. Write Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> 5. Copy Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> 
> Signed-off-by: Aman Gupta <aman1.gupta@samsung.com>
> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>

Adding Bjorn Helgaas to the thread.

Adding pcit test under selftests is good. There is another pcitest
under tools/pci. I would like to see if the existing code in
tools/pci/pcitest.c can be leveraged.

As part of this test work, also look into removing tools/pci so
we don't have to maintain duplicate code in two places.

thanks,
-- Shuah
