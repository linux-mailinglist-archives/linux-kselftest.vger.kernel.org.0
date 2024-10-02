Return-Path: <linux-kselftest+bounces-18899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BD298D72F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 15:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BF62851FE
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 13:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888791D04A5;
	Wed,  2 Oct 2024 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anNj8ghS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4A29CE7;
	Wed,  2 Oct 2024 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876806; cv=none; b=Jg+XM0yaAob4LWlCfUlyDPOSWTeaDj7Mse7xkkhrVxSR575rc8gRYx0oep0aaV8uSU9pSIOu3kDDUnyrV0/sO76K7ToRmWV419IvVFMW9u3T/55Vq4Z+vbCHQfCepIPn79Y6SFPtqJrQzVZfdIlpOfe7jLIbuGy2bJxdN2a71NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876806; c=relaxed/simple;
	bh=zAb+p4mjtI0JpaojawQRYgW/fLeeLxf7GSRYkTmirK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bR/bQdiDuoM5xGBxYbrgzqs8UpRUiIUNz7zn24tlY9x0EvFY0PDm/Ki4GhHPczhgFU8SL5Qi+Xy4Ctdjdftu9t1pDrF8rBrlVHahD9xF+a1+RMgF2vvlmxTmlMhPyIdOzPbN4TBM1xKqnFUR6M3Ay38LvvUuufPMZ3cmlMK7HvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anNj8ghS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20aff65aa37so53380105ad.1;
        Wed, 02 Oct 2024 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727876804; x=1728481604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TZiKLk+pldOod8+CZW2Q8qiPBGtS4WTMmt/umDCQNt8=;
        b=anNj8ghStgMZD2Zh21iIrqAcgHS/Ahfr0ou/Uu67wGzpT6zOvqNrpV11PJeDxegY3k
         hWAYMob71ai4FQBxjdqipebqyx9vtIvmwFWOpuzCFUvowQCr7XXJE7exSZIiHIAD5sXY
         cvUb/Z1aj9x4BtLkWd9DO0q1/9y2Mw22RyX0N9/p9gyflrfVRyGQZWyJw2zmLvfs1NyN
         6u5cuvYfUbcHmgFGodsUDMG3eKklSyCUv8rE846hlk/N6nev/KViCEDPVt7ruCzbY1XT
         jckeeSWhdGrvBkNtpY6Pr4zpCcsDcOuLtRPYUFbe47Hzmg9/NpKwkbMpKoFGfRjguiZb
         T0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727876804; x=1728481604;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZiKLk+pldOod8+CZW2Q8qiPBGtS4WTMmt/umDCQNt8=;
        b=o+l7tie+0oTFcVw5aT86M/GQxyUtip/OpQubyOplopQTTQHXYS0XD+9h7WmVMYX5OE
         28CNWURdvNYikTLko7rACr4PAZoWQ3javt9GuzgkDqRXNx2Uo+vaZ8+3eQTAcc32RWCD
         00FScPyzII75QDsFyQdXSTUE/8Hsdd8H3lU9VO2C9zklV9oGmVbPyGZoKWI/WUO/dL+j
         VPKL1UrmRVny/bKArb/+a1qwZXmHVTuWNYL/2FkHJVd2fKFO3jmzI5L71IuxxVfpvdxC
         5cmUcppQ3/nZSJrLaLrwrtKgEHYepTIGSMpZzw+D4i+WLAHkjAnxS9gzRnn0dJsIk+cz
         D55w==
X-Forwarded-Encrypted: i=1; AJvYcCUzQTyOr/HpCRG2ER8dr0xzckIbf5PJb5krIRmwqHuBxF+yF3yD5dJYyvZ0lox8MN0lOVTWXJMFP8FuNyPuBrVS@vger.kernel.org, AJvYcCVvLE16iLj4fJem4Yl/EaweR5AubH720r0ewRwoUjOKc77SpLhp2zxV11ZDzh7iOlum0tzD@vger.kernel.org, AJvYcCWcyJsYan2axJkwkHE07kumhYzYBd5bHdX2fQgAt7/orKRJ/ECzR/IWbqbwAGWYajG2MiNPRjKbdlJ661U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoS90760tYRxsJHANqBLPaIjoJaWOMVNJmZHTFyXZe3hjg+XeG
	qg4Ra1u9UxGMZO/sm583cBRzKp8qfrOwbuRmQ8ZC1bw26xUpRZm9sLf4jQ==
X-Google-Smtp-Source: AGHT+IGOIrt9h9YiJHWd+EI/3hVBa3Fizjqx+qD/0u9C5JJevMtgnKy+dkhUaYBKi3oSododR0ct5Q==
X-Received: by 2002:a17:902:e54b:b0:206:96bf:b0cf with SMTP id d9443c01a7336-20bc54c214bmr48473555ad.0.1727876804003;
        Wed, 02 Oct 2024 06:46:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0fd99sm84517085ad.173.2024.10.02.06.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 06:46:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <386e618b-d634-42a2-a518-ce2a70a8ef3e@roeck-us.net>
Date: Wed, 2 Oct 2024 06:46:41 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab hotfixes v2 2/2] slub/kunit: skip test_kfree_rcu when
 the slub kunit test is built-in
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 rcu@vger.kernel.org, David Gow <davidgow@google.com>,
 Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, Brendan Higgins <brendan.higgins@linux.dev>
References: <20241001-b4-slub-kunit-fix-v2-0-2d995d3ecb49@suse.cz>
 <20241001-b4-slub-kunit-fix-v2-2-2d995d3ecb49@suse.cz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241001-b4-slub-kunit-fix-v2-2-2d995d3ecb49@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/24 09:20, Vlastimil Babka wrote:
> Guenter Roeck reports that the new slub kunit tests added by commit
> 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and
> test_leak_destroy()") cause a lockup on boot on several architectures
> when the kunit tests are configured to be built-in and not modules.
> 
> The test_kfree_rcu test invokes kfree_rcu() and boot sequence inspection
> showed the runner for built-in kunit tests kunit_run_all_tests() is
> called before setting system_state to SYSTEM_RUNNING and calling
> rcu_end_inkernel_boot(), so this seems like a likely cause. So while I
> was unable to reproduce the problem myself, skipping the test when the
> slub_kunit module is built-in should avoid the issue.
> 
> An alternative fix that was moving the call to kunit_run_all_tests() a
> bit later in the boot was tried, but has broken tests with functions
> marked as __init due to free_initmem() already being done.
> 
> Fixes: 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and test_leak_destroy()")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/all/6fcb1252-7990-4f0d-8027-5e83f0fb9409@roeck-us.net/
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: rcu@vger.kernel.org
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

This results in:

     KTAP version 1
     # Subtest: slub_test
     # module: slub_kunit
     1..8
     # test_clobber_zone: pass:1 fail:0 skip:0 total:1
     ok 1 test_clobber_zone
     # test_next_pointer: pass:1 fail:0 skip:0 total:1
     ok 2 test_next_pointer
     # test_first_word: pass:1 fail:0 skip:0 total:1
     ok 3 test_first_word
     # test_clobber_50th_byte: pass:1 fail:0 skip:0 total:1
     ok 4 test_clobber_50th_byte
     # test_clobber_redzone_free: pass:1 fail:0 skip:0 total:1
     ok 5 test_clobber_redzone_free
     # test_kmalloc_redzone_access: pass:1 fail:0 skip:0 total:1
     ok 6 test_kmalloc_redzone_access
     # test_kfree_rcu: pass:0 fail:0 skip:1 total:1
     ok 7 test_kfree_rcu # SKIP can't do kfree_rcu() when test is built-in
     # test_leak_destroy: pass:1 fail:0 skip:0 total:1
     ok 8 test_leak_destroy
# slub_test: pass:7 fail:0 skip:1 total:8

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter


