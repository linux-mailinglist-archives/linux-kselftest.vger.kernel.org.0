Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3719D7A3E05
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Sep 2023 23:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbjIQVoQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Sep 2023 17:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239228AbjIQVnq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Sep 2023 17:43:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA828130
        for <linux-kselftest@vger.kernel.org>; Sun, 17 Sep 2023 14:43:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c39f2b4f5aso26930495ad.0
        for <linux-kselftest@vger.kernel.org>; Sun, 17 Sep 2023 14:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1694987020; x=1695591820; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EjYEVDeyXWGRfU5iV7LvJBf6c7N982G1lGvpbIPmcJ8=;
        b=KX8FblGrPINTGWJ+F+2OsLf/gAyXu98qR4yxI8s4WMVP0eTwMSfN6urkULb+FAZHtd
         rxzE+RJAhk50qj6AOC0t/OjpLK0vLxPsruIpQMsdUd0B5RfFHJTZ1NfRtGW2GNiwwAmX
         IQoHt9NRjqo7K0Yp7DjoEcV1TkJ9bGCmHIy49f9WKA8octbvKA/t1MtXI2yp6ZSVxCta
         IWXLEZewwro8H7U0M0RTvddQQjcFbDpSM6KTad4o/86uHXJazghPsvMQ/xXX8r6e1XTs
         c3J4COS3Wg46b4qkzZa6C2nxw7P/ZSrlehVzVRaYPFL6yaG7lBnDr4hdpFW+jN2Iyygf
         nOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694987020; x=1695591820;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjYEVDeyXWGRfU5iV7LvJBf6c7N982G1lGvpbIPmcJ8=;
        b=gEOsgG5zMcXnkf+zXxGNWGBWg2Eyx45jBUXYBlYBcO6LlAcoNnfb3ML4Lp16MnAP2Z
         KBzu29LbsfuM9QryN5Jh5x7InANqqLHMgHreVAsMzUYErLtDO9NeaJaX0LwRSBV+CUZX
         qOhxGjlA1uL7o/YjcPigQN3IQvzdhIoDpjDuGq2UZo68Pl6YP6kbSpBEyxYxinLOB8tn
         HCNg1MgzLArhKJ4+8t3qaWRCp/lMIHq8soukOutFlFDudBF/SqN1UJfOZI/7mGlw7ClZ
         S7FZHG7zQN/V/iLfxnnuGIA77e6t4RkyhRxKT3wrsvjVxRX2XayvnYFwYwfqM1N/xGcR
         pxGA==
X-Gm-Message-State: AOJu0YwWmMq+TiLOvbL0z7eskRSyM5TVjmtded6rOBH5ccWbu/VxKbew
        Y3oNIuyQE+NdONq4ySR8cpYnvg==
X-Google-Smtp-Source: AGHT+IFfMGfQ5zQmDSFheljxqnHWoOfv4bT82d7KBJ5y1wKvmf3MnOTX9NMedjj7EKPWak+DvfqHCA==
X-Received: by 2002:a17:903:25ca:b0:1c4:48c4:969b with SMTP id jc10-20020a17090325ca00b001c448c4969bmr4358364plb.52.1694987020400;
        Sun, 17 Sep 2023 14:43:40 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id h21-20020a170902f7d500b001ae0a4b1d3fsm7047393plw.153.2023.09.17.14.43.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Sep 2023 14:43:39 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Mario Limonciello'" <mario.limonciello@amd.com>,
        "'Swapnil Sapkal'" <swapnil.sapkal@amd.com>
Cc:     <rafael.j.wysocki@intel.com>, <Ray.Huang@amd.com>,
        <li.meng@amd.com>, <shuah@kernel.org>, <sukrut.bellary@gmail.com>,
        <gautham.shenoy@amd.com>, <wyes.karny@amd.com>,
        <Perry.Yuan@amd.com>, <zwisler@chromium.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "Doug Smythies" <dsmythies@telus.net>
References: <20230915104057.132210-1-swapnil.sapkal@amd.com>    <20230915104057.132210-3-swapnil.sapkal@amd.com>        <00b201d9e819$b2447e80$16cd7b80$@telus.net>     <2fd025a9-52f3-4922-99cf-82355b0e35fe@amd.com> <CAAYoRsUhusVzOnaGHjPoMWYy2_iPFAjFLoCrj6vSX26EHNWGiw@mail.gmail.com>
In-Reply-To: <CAAYoRsUhusVzOnaGHjPoMWYy2_iPFAjFLoCrj6vSX26EHNWGiw@mail.gmail.com>
Subject: RE: [PATCH 2/2] tools/power/x86/intel_pstate_tracer: Use pygnuplot package for Gnuplot
Date:   Sun, 17 Sep 2023 14:43:42 -0700
Message-ID: <001c01d9e9b0$073fadf0$15bf09d0$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKwVkrK5CGttHhKf0ienv16Lobu0QKE+b5tAruzzQ4BoCijAABix5Z4rjiS0sA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023.09.17 15:17 Doug wrote:
> On Fri, Sep 15, 2023 at 2:31=E2=80=AFPM Mario Limonciello
>> On 9/15/2023 16:15, Doug Smythies wrote:
>>> On 2023.09.15 03:41 Swapnil Sapkal wrote:
...
>>> Not really related, but for a few years now I have been meaning to
>>> change the minimum python version prerequisite to >=3D 3.0 and
>>> to change the shebang line.
...
>>  Besides the shebang, you should also
>> use a helper like 2to3 to look for any other changes.

Hi Mario,

I was not aware of the 2to3 helper.
Thank you mentioning it.
The 2to3 helper only changed one line,
which I included in the minimum python version
patch I just submitted.

> I already did the python 3 patch in January, 2020:
> commit e749e09db30c38f1a275945814b0109e530a07b0
> tools/power/x86/intel_pstate_tracer: changes for python 3 =
compatibility
>=20
> I haven't had any issues since, shebang aside.

... Doug


