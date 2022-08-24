Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2C459F682
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 11:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiHXJlg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 05:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiHXJlf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 05:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D763133345
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Aug 2022 02:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661334093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rXZAbOi80OJv3uidummRV0C+m8Czemv1wTSXuU14uGc=;
        b=N27Ewjd9B6KTvQuYFsvuwoBGrU3Dhf4T+6maws7V99qNznKp5Oi2Qy4tJUJFu+nudpWLSN
        r/SV0s69SksVE3MN/veXkM2fyZDEZfWyih2ISvzr5NdqVEtrUS4bK4OKPQGKNq2MunqiGi
        a65xLpVqxCHUBADCYGNBcfCyBc1dKOA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-425-bxdDysM5MHu9uBPV3ghlRQ-1; Wed, 24 Aug 2022 05:41:32 -0400
X-MC-Unique: bxdDysM5MHu9uBPV3ghlRQ-1
Received: by mail-wm1-f71.google.com with SMTP id x16-20020a1c7c10000000b003a5cefa5578so297571wmc.7
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Aug 2022 02:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rXZAbOi80OJv3uidummRV0C+m8Czemv1wTSXuU14uGc=;
        b=0qvwXYKsZHvgUc+UvdXlBVg5hsCbDb+mmm4Km2hUxhwH8Wh+AgkFdLfWWWj8MIq8x4
         CE1dtLNeYqsNXIMIo0CZ/j7CsC93DR1KOeiItTkDhU3rxSmCk7MqclHfE/Bvk/TsJmEw
         FqBNV8YwibCCzO8bK4Gw63SX4cYmHu4uQ7F0eLuPdiXRFhEKmyjhLi0IVF8uCplhiDjN
         8GcIWbXqTo589MNgN3CuWrvW+J7/g8geYQqDJkHrSgamLj2z04b+Fw/IZ3Cmr+bGWAU+
         LQy7GNDeESDsW11KQimJqqOEh0CIWx3HjZGNT3XRlUQALgiy1dXaGxB51h85bB+z2B2o
         sH7Q==
X-Gm-Message-State: ACgBeo1s8BQ0McQ/SDlhybsucdTRyKcLRRks9Zq8XWL/QBu8RHrFeVKO
        OA9pJ7p93AATpGun3/FVE1Jv3dww/jaf72yFKWsRe8z8XCr3Gz1T8LsJelJLh32zJeFOk1y3cTB
        /ayMDl8J79h+B1RGoi+55QeNRwsbc
X-Received: by 2002:adf:e4d0:0:b0:225:2947:3a5f with SMTP id v16-20020adfe4d0000000b0022529473a5fmr15483096wrm.387.1661334090890;
        Wed, 24 Aug 2022 02:41:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6A/ocXjWVRFdjan3P7MYJXQ6e2K34PdNA3e511oLDRA0aYA/dzfItM+B5KpyFeSSw6ofRRhg==
X-Received: by 2002:adf:e4d0:0:b0:225:2947:3a5f with SMTP id v16-20020adfe4d0000000b0022529473a5fmr15483088wrm.387.1661334090693;
        Wed, 24 Aug 2022 02:41:30 -0700 (PDT)
Received: from [192.168.110.200] (82-65-22-26.subs.proxad.net. [82.65.22.26])
        by smtp.gmail.com with ESMTPSA id bh19-20020a05600c3d1300b003a2f6367049sm1335730wmb.48.2022.08.24.02.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 02:41:29 -0700 (PDT)
Message-ID: <ecb5c967-9913-73e0-65a6-e35893eee411@redhat.com>
Date:   Wed, 24 Aug 2022 11:41:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v7 13/24] HID: initial BPF implementation
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
References: <20220721153625.1282007-1-benjamin.tissoires@redhat.com>
 <20220721153625.1282007-14-benjamin.tissoires@redhat.com>
 <YuKaG18WXkkQlu8e@kroah.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
In-Reply-To: <YuKaG18WXkkQlu8e@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Greg,

On 7/28/22 16:15, Greg KH wrote:
> On Thu, Jul 21, 2022 at 05:36:14PM +0200, Benjamin Tissoires wrote:
>> diff --git a/drivers/hid/bpf/Kconfig b/drivers/hid/bpf/Kconfig
>> new file mode 100644
>> index 000000000000..423c02e4c5db
>> --- /dev/null
>> +++ b/drivers/hid/bpf/Kconfig
>> @@ -0,0 +1,18 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +menu "HID-BPF support"
>> +	#depends on x86_64
> 
> Is this comment still needed?

Nope. It was required a few months ago, but I think we now have 
trampoline support also for aarch64, which are the 2 main architectures 
we care right now.

Dropping this from the series.

Cheers,
Benjamin

> 
>> +
>> +config HID_BPF
>> +	bool "HID-BPF support"
>> +	default HID_SUPPORT
>> +	depends on BPF && BPF_SYSCALL
>> +	help
>> +	This option allows to support eBPF programs on the HID subsystem.
>> +	eBPF programs can fix HID devices in a lighter way than a full
>> +	kernel patch and allow a lot more flexibility.
>> +
>> +	For documentation, see Documentation/hid/hid-bpf.rst
>> +
>> +	If unsure, say Y.
>> +
>> +endmenu
> 

