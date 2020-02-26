Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBE41702EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2020 16:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgBZPnc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Feb 2020 10:43:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53439 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgBZPn3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Feb 2020 10:43:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id f15so2807062wml.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2020 07:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I5/BA7YsbH1T9sgkRZT9CG8Y5s0Fng9eOPPb7ZuWHYE=;
        b=h0CZuuEJRdVegqyi13c89qiGXx60eLvFkx/GwHshqfyg1vU877SDUzDDB7+QbtC1W4
         IhZXFnKEfR6MW0VSVVOY+sD9tqlAd3SGcdRXz/PyPZ0jdPpGRsh2lcvncF42WgrK27QA
         18DpuPtuP6ADT4RB6IyZtgqcVTX3AyvYrzENEk1ViR0tR3gsqakChr/D4VcH1LaAL9Gk
         CRBXOTzhlF30dp3sFSmjBlEtQdmwO4QP+HtcY9ByqIueXHuhOxr+7aW2BmhWQ+tGZu+6
         Ct7qXdZCDPqKlJlnDVNVP8qqZkPvyqzBNWIVMTbxgiySJl2kSbTgfMzHdVSAMMMibvHi
         yYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I5/BA7YsbH1T9sgkRZT9CG8Y5s0Fng9eOPPb7ZuWHYE=;
        b=pHE/YYNW3CqFrMDviLwNRCaox0IHALpMyML514jWE+ipd3nSJbIIbf/OwhHtYzwf7A
         Hj+VTv7GgWy3LrXBT32ELXP1MDN5uv6kNGslvx6uVlCXDXEZocf6GQe3RCcxTYZPmVqx
         LhXFFPJY44qtYhyN+v7Kb51+7WfwCiFVyZ+ctl/8TL7OZW7q4/SbCtRZmbMyvhFL2m24
         TMKz9Z1dcygxkYavBnoHmMJSD2ue9T0I1jWPEkLFqlRMVZP35xEAXXkAeAskAcSeO3oh
         dq08mFrK0qr1SHVkrpUGIt/avvknjkiC2vzUSa2o+95zo1CMUwPJQkiBcWXk5PqNm5FH
         ct8A==
X-Gm-Message-State: APjAAAW44CiObWp7rRob4yvmnVEscl+v0p8fPArJdNVx+X/Gi2A/7crf
        bCGw3C2vi9uJ99uX6UkFd7/0bQlC2Ho=
X-Google-Smtp-Source: APXvYqyBpiXgO5JATr9oE7f1ctrb6q9k+9T8pBp8B9tz+Bz4xDU3/9j3M2yLGFRhzsynf86yERgMBQ==
X-Received: by 2002:a05:600c:211:: with SMTP id 17mr6214941wmi.60.1582731806522;
        Wed, 26 Feb 2020 07:43:26 -0800 (PST)
Received: from [192.168.1.10] ([194.35.116.65])
        by smtp.gmail.com with ESMTPSA id s139sm3528634wme.35.2020.02.26.07.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 07:43:25 -0800 (PST)
Subject: Re: [PATCH bpf-next v3 5/5] selftests/bpf: Add test for "bpftool
 feature" command
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Michal Rostecki <mrostecki@opensuse.org>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kselftest@vger.kernel.org
References: <20200225194446.20651-1-mrostecki@opensuse.org>
 <20200225194446.20651-6-mrostecki@opensuse.org>
 <d0c40cd0-f9db-c6cb-5b46-79145311050d@iogearbox.net>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <3e485c13-e478-c0b3-39e4-595dbd968ea2@isovalent.com>
Date:   Wed, 26 Feb 2020 15:43:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d0c40cd0-f9db-c6cb-5b46-79145311050d@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

2020-02-26 16:34 UTC+0100 ~ Daniel Borkmann <daniel@iogearbox.net>
> On 2/25/20 8:44 PM, Michal Rostecki wrote:
>> Add Python module with tests for "bpftool feature" command, which mainly
>> wheck whether the "full" option is working properly.
> 
> nit, typo: wheck
> 
>>
>> Signed-off-by: Michal Rostecki <mrostecki@opensuse.org>
> 
> Ptal, when running the test I'm getting the following error:
> 
> root@tank:~/bpf-next/tools/testing/selftests/bpf# ./test_bpftool.sh
> test_feature_dev_json (test_bpftool.TestBpftool) ... ERROR
> test_feature_kernel (test_bpftool.TestBpftool) ... ERROR
> test_feature_kernel_full (test_bpftool.TestBpftool) ... ERROR
> test_feature_kernel_full_vs_not_full (test_bpftool.TestBpftool) ... ERROR
> test_feature_macros (test_bpftool.TestBpftool) ... ERROR
> 
> ======================================================================
> ERROR: test_feature_dev_json (test_bpftool.TestBpftool)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>    File "/root/bpf-next/tools/testing/selftests/bpf/test_bpftool.py", 
> line 58, in wrapper
>      return f(*args, iface, **kwargs)
>    File "/root/bpf-next/tools/testing/selftests/bpf/test_bpftool.py", 
> line 83, in test_feature_dev_json
>      res = bpftool_json(["feature", "probe", "dev", iface])
>    File "/root/bpf-next/tools/testing/selftests/bpf/test_bpftool.py", 
> line 43, in bpftool_json
>      res = _bpftool(args)
>    File "/root/bpf-next/tools/testing/selftests/bpf/test_bpftool.py", 
> line 34, in _bpftool
>      res = subprocess.run(_args, capture_output=True)
>    File "/usr/lib/python3.6/subprocess.py", line 423, in run
>      with Popen(*popenargs, **kwargs) as process:
> TypeError: __init__() got an unexpected keyword argument 'capture_output'


Apparently the “capture_output” option for subprocess was added to 
python 3.7 [0]. It worked on my system (python 3.7.5) but didn't pass on 
yours with 3.6.

Michal, can you change it to something less recent please, so that 
people don't have to upgrade python to test?

Quentin

[0] https://docs.python.org/3/whatsnew/3.7.html#subprocess
