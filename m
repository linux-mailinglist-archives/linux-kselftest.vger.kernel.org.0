Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3B47E4AA8
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 22:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjKGV1j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 16:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjKGV1i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 16:27:38 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65C0D7A
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Nov 2023 13:27:36 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-35950819c97so4144165ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Nov 2023 13:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699392456; x=1699997256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAsdvc2tC0sZt5WnSCuHJooOBmtzWwDbQfPc2qj2gPk=;
        b=ZO3LDLzd6BQA3wJzRa+jiKr+PjkD3R34WcTTTRVEEn8M5cCgv0XMyGyIAXd7FNgd7/
         DnRFUgLWcMcteggwLGfudp8Ov5nouLuKU921diuXmUouypcpGyM06a80sA5QYnw7NAby
         H8OqmNRyHP+rwh3WOpstcr3z/5dZlw7iNNCCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699392456; x=1699997256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAsdvc2tC0sZt5WnSCuHJooOBmtzWwDbQfPc2qj2gPk=;
        b=m8bDXkXgOs3yFhkNydGX8H5cqyZz/PQD1z8Q1j1OQ+BTlaNI3HA1/L7LPxcY1gkyP1
         zk6GMyrUmtyZuB+LspDE8FItWQmP2iqymeft11Wjd+XgQVQh6qqEUE69EkL8YQJEutjA
         KHlAyTKzqI4ulomvaKkanAe4Szjc/BPioAgnSScT90x2o13HoKUvOoJeC+h3tBIN3d65
         e+U+UoB29ofR8umcumhJSvD37XeJy2x92qG9WFb1MVyAcQJSnQY08JBGGZX2psfd55eC
         1krwc/CYjWkuahpyJTYmcCmBAtMorxknUdTZ78Gac5C5L8aRC++thPH2HSepzOhPfEAj
         ryEg==
X-Gm-Message-State: AOJu0Yyr7TzubpGzGd0VFy47EKMAbuLOUoFHZRcJimKw3jzKstiGJzx8
        mWk30mj0l+54uxQEgFhdJX74lA==
X-Google-Smtp-Source: AGHT+IGYtf5cyHwW5eJuAjjUmSGEMSQJ1dHkg8TrWpxZ3Ug1cH9OGIvl+qJ+v74/c3leRuemUosFxg==
X-Received: by 2002:a05:6602:b8c:b0:792:7c78:55be with SMTP id fm12-20020a0566020b8c00b007927c7855bemr176006iob.0.1699392456202;
        Tue, 07 Nov 2023 13:27:36 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m15-20020a056638224f00b004500f7a5903sm2937020jas.102.2023.11.07.13.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 13:27:35 -0800 (PST)
Message-ID: <22df3ecb-488c-4d58-8efe-4638fa3d614b@linuxfoundation.org>
Date:   Tue, 7 Nov 2023 14:27:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] selftests: rtc: Fixes rtctest error handling.
Content-Language: en-US
To:     Atul Kumar Pant <atulpant.linux@gmail.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     shuah@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230817091401.72674-1-atulpant.linux@gmail.com>
 <20230923173652.GC159038@atom0118> <20231007154318.GC20160@atom0118>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231007154318.GC20160@atom0118>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/7/23 09:43, Atul Kumar Pant wrote:
> On Sat, Sep 23, 2023 at 11:06:58PM +0530, Atul Kumar Pant wrote:
>> On Thu, Aug 17, 2023 at 02:44:01PM +0530, Atul Kumar Pant wrote:
>>> Adds a check to verify if the rtc device file is valid or not
>>> and prints a useful error message if the file is not accessible.
>>>
>>> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
>>> ---


Sorry for the delay. I will pick this up for the next rc.

thanks,
-- Shuah
