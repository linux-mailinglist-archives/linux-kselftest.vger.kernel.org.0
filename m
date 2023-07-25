Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1C3761C4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 16:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjGYOzq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 10:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjGYOzp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 10:55:45 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65896E78
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 07:55:44 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-760dff4b701so68648139f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690296944; x=1690901744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=poOkid89WcEeHCeXFL1hv/OL8I2gj/LJb9FhxsPb1Uc=;
        b=NSF2vx4e/ZSu2tp/7tSxXs5FJM3Tl8H6R1YIzJ7aBmw6h4/+vbz5PWM98hGij52c5Y
         kuTAbUlGUpHR+Nh1+P6LXJAgh7D8O/nebeUfhlIDpK4RSpwt0916C2FBAU7NlWFPNsHo
         6yWELUwa7YfShDcTtpukTkAj+QMRm9rIgrxlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690296944; x=1690901744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poOkid89WcEeHCeXFL1hv/OL8I2gj/LJb9FhxsPb1Uc=;
        b=DPEc9hCk2b2WIlEZ1LE7mEp4BeKzPn21E7E4HyQo2aHzigul4XHhesGVo3oiWCJcqa
         FUwooeZrNPnKuduxWB5wEEK7ipBPXz6c+ZhiRTPtwSUVBsIfDrno7Kg7XVjDE1mO/7z/
         rw5qdlt2mrTVOwL8KW6TGs5duyXxNk/RZ4QApFxHh2t5B1QiUnyU0Hn8K5jEkLNk6wC5
         u8Ynxph9frBu16aFxREemfpDLYxj4WJMmJyNqrbUD+89bDGuVbprSRoHFkXBNZaD03Tb
         nzxU52ryw/4h/+ZUu6D2xkvIYZBpqHitRT/0YcJae2Jb2pkRkiPS3k7lsNJXqh4zU7R5
         dT5A==
X-Gm-Message-State: ABy/qLY67rAkMQG9vMso/qwgUl8uOLUml/mUEFYcM5hn8Zr7SIcjawwS
        wxdFN+qcv/sRej3OVvYPvq1RiA==
X-Google-Smtp-Source: APBJJlHfdriZne2soE8HHVdEwEkNGZ9Ol4beSAt414g1akSKUSfQrIDfA6XTzFn0bxLh0NQ0xm3Xng==
X-Received: by 2002:a92:c9c3:0:b0:341:c98a:529 with SMTP id k3-20020a92c9c3000000b00341c98a0529mr9987176ilq.0.1690296943844;
        Tue, 25 Jul 2023 07:55:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p18-20020a92da52000000b00348e9aa50c8sm33229ilq.60.2023.07.25.07.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 07:55:43 -0700 (PDT)
Message-ID: <c36c25ad-4c09-cef2-76a1-1eb8fe7ee927@linuxfoundation.org>
Date:   Tue, 25 Jul 2023 08:55:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 00/19] selftests/resctrl: Fixes and cleanups
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/17/23 07:14, Ilpo Järvinen wrote:
> Here is a series with some fixes and cleanups to resctrl selftests.
> 
> v5:
> - Improve changelogs
> - Close fd_lm only in cat_val()
> - Improve unmount error handling
> 

Applied to linux-kselftest next for Linux 6.6-rc1

thanks,
-- Shuah

