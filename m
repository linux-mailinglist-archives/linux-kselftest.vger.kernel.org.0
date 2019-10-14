Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67477D6529
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2019 16:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbfJNO3n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Oct 2019 10:29:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36759 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNO3n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Oct 2019 10:29:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so10515471pfr.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2019 07:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/5HMWoJTwsEo72eQ/9NRVyic0gSpYQQaazkRTolMfEM=;
        b=LOzrovO+0UbvVs3I/jB8Z5Vbif1QgLCYn5PwVeiueFhBiJHFFYY+xm1Mt//Uf1z9T5
         vNytahyX2ctutnUQGN0dycaAgQXnzkr34AQqcExEudMWC3woBrsYHTFGoDSScEBNwTL0
         7tpOKR4kYSAGjNx7MMuWrW2RRcPuX0n80qaatku+XR6r7A41SjI37Lk41KFR2IprDAlq
         1ZhVjpZfOx0HrIgSxeR3UGklU3uk2ntbGMqyy71l/uIRc2+YfnEtmJDJsrTjB1BOY5zg
         Fuq+ppXKcx2D2mUZUccIFH2sSbA7Opqjakhf1MOISJrIS1qhn+m1F0HzwSdKb71kQE1h
         5fEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/5HMWoJTwsEo72eQ/9NRVyic0gSpYQQaazkRTolMfEM=;
        b=axv/+3j9tR9oEAixfz38UZnJfpho1S3CSPMO6g3khpTv9jAR34eRTzfvWTvOdv1Idz
         ZDVnIOYZ4A3/KY6HTgDF30TxPKTYArdk57UQCsoJ9hEYCuBI6goAwEOBGrT9oY8oOn4B
         DQj1bTooSsuEf6V452GIKRaww1qnzx1jnxCkgtf0iUeTHjQGH5DPOYFl7rYruHD4ew66
         mMeD6ptu6LDj7o7U0RREv1RslGvqowmo6lxQMTx5Rbv4U6lMdUlG2N72hd+kTDT1g/At
         y7nqVkf8y0U6dQWL0Y4y+/tHfRCClRWlK8NRJhqr5fR9j76TANu+XfV15kvHeABsgGwn
         pXrA==
X-Gm-Message-State: APjAAAVWluHpSXSDhm/wD4omQVM8YRVzsaJE8Gbs9QzASU8iEvASEO/z
        alnoI8t7DMJrPKKJQzkJryzI5OKe
X-Google-Smtp-Source: APXvYqy2E+k5Pr+q8rQcMzaN5/j/UIBgXFax+u6MJ0/lVWfKdUVkpBx7bd1E/OxsEIIdENLG086KOQ==
X-Received: by 2002:a63:7c4f:: with SMTP id l15mr12605658pgn.408.1571063382569;
        Mon, 14 Oct 2019 07:29:42 -0700 (PDT)
Received: from [192.168.31.113] ([43.224.157.52])
        by smtp.gmail.com with ESMTPSA id h68sm22767346pfb.149.2019.10.14.07.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 07:29:42 -0700 (PDT)
Subject: Re: kseltest: bpf: test_lwt_ip_encap.sh: Why -l used in test_gso
To:     Liu Yiding <liuyd.fnst@cn.fujitsu.com>,
        linux-kselftest@vger.kernel.org
References: <731bcbd4-0e01-245a-8f8d-bec8024868ca@gmail.com>
 <3c6ba815-6d95-e550-2983-ee40790ec495@cn.fujitsu.com>
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Message-ID: <93c27247-ff1a-8e31-ff25-ac6966560d93@gmail.com>
Date:   Mon, 14 Oct 2019 19:59:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <3c6ba815-6d95-e550-2983-ee40790ec495@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/14/2019 12:04 PM, Liu Yiding wrote:
> Hi, Kushwaha.
> 
> 
> On 10/13/19 9:59 AM, Prabhakar Kushwaha wrote:
>> Hi All,
>>
>> I am trying to understand test_gso test for IPv4 and IPv6 with 
>> following piece of code
>>
>>       # listen on IPv*_DST, capture TCP into $TMPFILE
>>         if [ "${PROTO}" == "IPv4" ] ; then
>>                 IP_DST=${IPv4_DST}
>>                 ip netns exec ${NS3} bash -c \
>>                        "nc -4 -l -s ${IPv4_DST} -p 9000 > ${TMPFILE} &"
>>         elif [ "${PROTO}" == "IPv6" ] ; then
>>                 IP_DST=${IPv6_DST}
>>                 ip netns exec ${NS3} bash -c \
>>                        "nc -6 -l -s ${IPv6_DST} -p 9000 > ${TMPFILE} &"
>>                 RET=$?
>>         else
>>                 echo "    test_gso: unknown PROTO: ${PROTO}"
>>     fi
>>
>> I have couple of queries around it
>>
>> a) why -l is being used for reading listen on IPv*_DST with -s option.
>> I was looking at https://www.computerhope.com/unix/nc.htm, following 
>> has been mentioned:
>> -l :  Used to specify that nc should listen for an incoming connection 
>> rather than initiate a connection to a
>> remote host. It is an error to use this option in conjunction with the 
>> -p, -s, or -z options.
>> Additionally, any timeouts specified with the -w option are ignored.
>>
>> b) Even if there is requirement of -l option to use. can we provide 
>> timeout option also. how? as -w dont work with -l.
>>
>>
>> I am facing an issue with Linux-5.3 Kselftest where even if 
>> test_lwt_ip_encap.sh "exit", bpf/runner.sh is not
>> running next test case. It just wait until CRTL + c is pressed.
> 
> 
> I meet same issue. "make run_tests -C bpf" bpf/runner.sh hang on 
> test_lwt_ip_encap.sh. And when i skip it,
> 
> test_tc_tunnel.sh also has this problem.
> 
> 

does this means, the problem is independent of "nc" and has no relation 
with nc usage with -l option.

has anyone find it's root-cause..

-prabhakar (pk)


