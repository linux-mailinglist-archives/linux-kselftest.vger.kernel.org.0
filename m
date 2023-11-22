Return-Path: <linux-kselftest+bounces-453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDB87F4E9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 18:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691D52812BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0F256B75;
	Wed, 22 Nov 2023 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmNmekWN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89FCBC
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 09:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700675074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5lOHzNfXo9jQJ5tg2RkdaViH4dDlpDTOZxGJF246r4=;
	b=ZmNmekWNUlcgjbbr31LxLsr7c51Iq/WGwyikEpCipKeQDq4H6A+aPnmg9NAWLtsbfHDavj
	3FVu8CQbtpWZ0Q6vSxDk1SK5ibEWVfRV58v5uAeIcEepuUdYxVwnM4rv9Nmvlp1kPtouV5
	KT4LeeBQ0tkjwcDpxEEeRQIFMc+tfog=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-e4uSsIWUNFSzknx4W-wqDQ-1; Wed, 22 Nov 2023 12:44:32 -0500
X-MC-Unique: e4uSsIWUNFSzknx4W-wqDQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41e172143c3so23475961cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 09:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700675072; x=1701279872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5lOHzNfXo9jQJ5tg2RkdaViH4dDlpDTOZxGJF246r4=;
        b=C58bMvX6+qWzYLiMt+LplihUOIdwQTsXUEyBun3+19xUZVkRovFNmjD5PbH3IUMsIp
         DpeFSk40auF2WCx6dgbK7WIAoWUtPQyezOSXyijlSHpWHNXVupSMSUgezbKA/wlzzyOq
         GuckQKo45283hCEZXbfZHJrlgZezzvSggcl6B30NCkXxXtzslPOWEoxXBZuHsFViMo+O
         JIi2nGzrSLAM9EAfZLiq1q/nNz4DtJ2BpjUdlzjhJpt3rdTGGUca8PeH2OVoIeOAGM1x
         Q+1zz14IzNkgHh3bEMHred0p4c6oFWxyWkSk9wT7qC4rF0U5PA449uj2lkmmsAmojuaA
         V6Mg==
X-Gm-Message-State: AOJu0YyPD8lscgLm8fPu7Gt9wYi1RI7a3krMwO3aUH8D752WfLK9uod9
	NSmD+4EtdACexOMGUqF1xAe6fGQHHALNCmtyPNM6Japf/r2IG+0BmESsS5lVjACluYnHQDyNS2q
	n0hVq+lT1yQoBgAKvuwqODZj+9vhL
X-Received: by 2002:ac8:51c9:0:b0:3f9:aa80:b48a with SMTP id d9-20020ac851c9000000b003f9aa80b48amr266209qtn.8.1700675071782;
        Wed, 22 Nov 2023 09:44:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEswk2Ukh1tn1H1mnSGmVcXNR1Gd8/lMKUbZkOe2oc6oAY0mfcDn6I/97xKBvGL3mF2zqL3OQ==
X-Received: by 2002:ac8:51c9:0:b0:3f9:aa80:b48a with SMTP id d9-20020ac851c9000000b003f9aa80b48amr266182qtn.8.1700675071483;
        Wed, 22 Nov 2023 09:44:31 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id c15-20020ac87d8f000000b0042382bfae48sm346734qtd.76.2023.11.22.09.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 09:44:30 -0800 (PST)
Message-ID: <8573add2-73db-4783-be90-389a2f076ea9@redhat.com>
Date: Wed, 22 Nov 2023 19:44:26 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] MAINTAINERS: Require kvm-xfstests smoke for ext4
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Chandan Babu R <chandanbabu@kernel.org>,
 workflows@vger.kernel.org, Joe Perches <joe@perches.com>,
 Andy Whitcroft <apw@canonical.com>, David Gow <davidgow@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, Veronika Kabatova <vkabatov@redhat.com>,
 CKI <cki-project@redhat.com>, kernelci@lists.linux.dev,
 Chandan Babu R <chandanrlinux@gmail.com>, Dave Chinner <david@fromorbit.com>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-3-Nikolai.Kondrashov@redhat.com>
 <20231115185808.GD36211@frogsfrogsfrogs>
 <87v8a096cr.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20231119225437.GA292450@mit.edu>
 <cd2d6ed9-7047-4090-ab44-16540f503087@redhat.com>
 <20231122161746.GM36211@frogsfrogsfrogs>
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <20231122161746.GM36211@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/23 18:17, Darrick J. Wong wrote:
> On Wed, Nov 22, 2023 at 04:44:58PM +0200, Nikolai Kondrashov wrote:
>> On 11/20/23 00:54, Theodore Ts'o wrote:
>> I already queued a switch to the kernel.org URL, which Darrick has suggested.
>> I'll drop it now, but you guys would have to figure it out between yourselves,
>> which one you want :D
>>
>> Personally, I agree that the one on GitHub is more reader-friendly, FWIW.
> 
> For xfstests-bld links, I'm ok with whichever domain Ted wants.

Great! I just hope I can keep track of all the requests :D

>>> And similarly, just because the V: line might say, "kvm-xfstests
>>> smoke", someone could certainly use kdevops if they wanted to.  So
>>> perhaps we need to be a bit clearer about what we expect the V: line
>>> to mean?
>>
>> I tried to handle some of that with the "subsets", so that you can run a wider
>> test suite and still pass the Tested-with: check. I think this has to be
>> balanced between allowing all the possible ways to run the tests and a
>> reasonable way to certify the commit was tested automatically.
>>
>> E.g. name the test "xfstests", and list all the ways it can be executed, thus
>> communicating that it should still say "Tested-with: xfstests" regardless of
>> the way. And if there is a smaller required subset, name it just "xfstests
>> smoke" and list all the ways it can be run, including the simplest
>> "kvm-xfstests smoke", but accept just "Tested-with: xfstests-smoke".
>>
>> I'm likely getting things wrong, but I hope you get what I'm trying to say.
> 
> Not entirely -- for drive-by contributions and obvious bugfixes, a quick
> "V: xfstests-bld: kvm-xfstests smoke" / "V: fstests: ./check -g smoke"
> run is probably sufficient.
> 
> (Insofar as n00bs running ./check isn't sufficient, but that's something
> that fstests needs to solve...)
> 
> For nontrivial code tidying, the author really ought to run the whole
> test suite.  It's still an open question as to whether xfs tidying
> should run the full fuzz suite too, since that increases the runtime
> from overnightish to a week.
> 
> For /new features/, the developer(s) ought to come up with a testing
> plan and run that by the community.  Eventually those will merge into
> fstests or ktest or wherever.

Of course, makes sense. Thank you!

Nick


