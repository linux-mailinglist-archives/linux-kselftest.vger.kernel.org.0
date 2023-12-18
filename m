Return-Path: <linux-kselftest+bounces-2162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B118177C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 17:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616FB28441B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 16:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD02A49887;
	Mon, 18 Dec 2023 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DX9p3/eh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261761E4AF
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Dec 2023 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702917868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMTA3QS7Ta1E6WqgyFWJhRzsScQ6pkKj8ELIzJ0/KvY=;
	b=DX9p3/ehrshn82INOFXCCMub4T8e1mh+1L8PqV7Bla7Cq6YaPGXRpsJ3b3PRBOQRXVNT6I
	jQSTYA4vS+RCVxt8wKrGzPcTSdXkzgyjzc91iTQ5PeM4QbNQ07AFv/h7dd5qSMtrF51kp/
	GGMh/2+LQ7OD7U406IBJ/EzDNiUdTCQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-O3Yhm_g1NDGzkCCLPdnUZg-1; Mon, 18 Dec 2023 11:44:25 -0500
X-MC-Unique: O3Yhm_g1NDGzkCCLPdnUZg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67f299d3c7bso40979696d6.3
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Dec 2023 08:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917865; x=1703522665;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMTA3QS7Ta1E6WqgyFWJhRzsScQ6pkKj8ELIzJ0/KvY=;
        b=JlGZqAlFqQ5mvoYUWYhPQnp16K4KqnR68ARQQj1NjX+cxCTh1ucLYo+CTqiPSzlQor
         QqLb8PtaClFQkrAsRL1mfLEAxKBsoRZPMSfZMzSunDh2aZs+CArE9OS4lMvp9PqlOwtF
         9e56UexRimI93J722g/hIXOTBEv+Sg5p5iaDocT8FaNGbjVOlpBOzt7JJ10Y+C+3F5dZ
         jR/2WpjDsJ+aUC0QIixlSmPryhrxNLX1PLcw8VQXp+4r1FyIIqLjytbhhGCfR+E+Upc3
         i4B9Yy4qEZITOjzWqmvjt9v0glOWO6BDYzLZK4T5JOOII+6MGw548TDYs2XDE8KRYHxY
         pl5w==
X-Gm-Message-State: AOJu0YyCm5jAVdPk0E1D+6XAgWYbULAt8OfTk44PBo2UltWVgp7Dg1up
	T8tcKOYUva+7RAsYpsTP8vxAQRYvFj5rx6pWyjZS3/D5ChmWTmZD7u0c5h4T7bHRmgUjMx1jnVj
	1YuEQs14qw3lDBFQTy9Muy7uGqqpi
X-Received: by 2002:a05:6214:2529:b0:67f:2f9a:6c54 with SMTP id gg9-20020a056214252900b0067f2f9a6c54mr6330956qvb.85.1702917865400;
        Mon, 18 Dec 2023 08:44:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLOQvRjA6fmEi2zpxmpKYqxRhZ1i6tiDsOyYqL94EBT+uZcrgKk5rSANjTbDjDVJ7YWgLPLg==
X-Received: by 2002:a05:6214:2529:b0:67f:2f9a:6c54 with SMTP id gg9-20020a056214252900b0067f2f9a6c54mr6330942qvb.85.1702917865134;
        Mon, 18 Dec 2023 08:44:25 -0800 (PST)
Received: from [192.168.1.14] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id f5-20020a0cc305000000b0067f2b6fe775sm2018092qvi.131.2023.12.18.08.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 08:44:24 -0800 (PST)
Message-ID: <cf087c7e-d24d-5cee-eadd-dd1fe26efe39@redhat.com>
Date: Mon, 18 Dec 2023 11:44:23 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Alexander Gordeev <agordeev@linux.ibm.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <ZYAimyPYhxVA9wKg@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: selftests/livepatch fails on s390
In-Reply-To: <ZYAimyPYhxVA9wKg@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/23 05:44, Alexander Gordeev wrote:
> Hi all,
> 
> The livepatch selftest somehow fails in -next on s390 due to what
> appears to me as 'comm' usage issue. E.g the removal of timestamp-
> less line "with link type OSD_10GIG." in the below output forces 
> 'comm' to produce the correct result in check_result() function of
> tools/testing/selftests/livepatch/functions.sh script:
> 
> [   11.229256] qeth 0.0.bd02: qdio: OSA on SC 2624 using AI:1 QEBSM:0 PRI:1 TDD:1 SIGA: W 
> [   11.250189] systemd-journald[943]: Successfully sent stream file descriptor to service manager.
> [   11.258763] qeth 0.0.bd00: Device is a OSD Express card (level: 0165)
>                with link type OSD_10GIG.
> [   11.259261] qeth 0.0.bd00: The device represents a Bridge Capable Port
> [   11.262376] qeth 0.0.bd00: MAC address b2:96:9c:49:aa:e9 successfully registered
> [   11.269654] qeth 0.0.bd00: MAC address 06:c6:b5:7d:ee:63 successfully registered
> 
> By contrast, using the 'diff' instead works as a charm. But it was
> removed with commit 2f3f651f3756 ("selftests/livepatch: Use "comm"
> instead of "diff" for dmesg").
> 
> I am attaching the contents of "$expect" and "$result" script
> variables and the output of 'dmesg' before and after test run
> dmesg-saved.txt and dmesg.txt.
> 
> Another 'dmesg' output dmesg-saved1.txt and dmesg1.txt also
> shows the same problem, which seems like something to do with
> sorting.
> 
> The minimal reproducer attached is dmesg-saved1-rep.txt and
> dmesg1-rep.txt, that could be described as:
> 
> --- dmesg-saved1-rep.txt	2023-12-17 21:08:14.171014218 +0100
> +++ dmesg1-rep.txt	2023-12-17 21:06:52.221014218 +0100
> @@ -1,3 +1,3 @@
> -[   98.820331] livepatch: 'test_klp_state2': starting patching transition
>  [  100.031067] livepatch: 'test_klp_state2': completing patching transition
>  [  284.224335] livepatch: kernel.ftrace_enabled = 1
> +[  284.232921] ===== TEST: basic shadow variable API =====
> 
> The culprit is the extra space in [   98.820331] timestamp, that from
> the script point of view produces the output with two extra lines:
> 
> [  100.031067] livepatch: 'test_klp_state2': completing patching transition
> [  284.224335] livepatch: kernel.ftrace_enabled = 1
> [  284.232921] ===== TEST: basic shadow variable API =====
> 
> If the line with [   98.820331] timestamp removed or changed to e.g
> [  100.031066] (aka 1 us less), then the result output is as expected:
> 
> [  284.232921] ===== TEST: basic shadow variable API =====
> 
> Thanks!

Hi Alexander,

You're right about the timestamp formatting.  I can repro with a a
slight variant on your example:

Assume a pre-test dmesg log has three msgs (including one with timestamp
of fewer digits):

  $ head /tmp/{A,B}
  ==> /tmp/A <==
  [ 1] message one
  [10] message two
  [11] message three

during the rest, the first message rolls off the buffer post-test and a
new fourth message is added:

  ==> /tmp/B <==
  [10] message two
  [11] message three
  [12] message four

The test's comm invocation should be only printing "lines unique to
FILE2", ie, the latest fourth message, but...

  $ comm --nocheck-order -13 /tmp/A /tmp/B
  [10] message two
  [11] message three
  [12] message four

If we pre-trim the timestamps, the output is what we expect:

  $ comm --nocheck-order -13 \
      <(sed 's/^\[[ 0-9.]*\] //' /tmp/A) \
      <(sed 's/^\[[ 0-9.]*\] //' /tmp/B)
  message four

however, I'm not sure if that fix would easily apply.  It looks like I
provided a disclaimer notice in check_result():

	# Note: when comparing dmesg output, the kernel log timestamps
	# help differentiate repeated testing runs.  Remove them with a
	# post-comparison sed filter.

so I wonder if comm will get confused with repeated selftest runs?
Using diff/comm was a trick that I surprised worked this long :) Maybe
it can still hold, but I'll have to run a few experiements.

-- 
Joe


