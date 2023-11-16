Return-Path: <linux-kselftest+bounces-227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7643C7EE53B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 17:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8076EB20CF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D192FE3D;
	Thu, 16 Nov 2023 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsIxlvly"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CEED4B
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Nov 2023 08:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700152390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2R1YGHbVqaFXfxAjW2H0oaW69e+Pupsv8J1Jh5FYd8=;
	b=UsIxlvlyg+TUDFZqbkeGCE4cJM/jEonv4NjpfoBXrM2KNVUbERl/mnwaXzTojNfqxec3rk
	IP6HK6uREO+qTQDReyNWAzHhE9XGY3U4mglsa4PvNabr2KnzLbMq9ojJEhC5NekUI2/Nqt
	1oBLfYtSWV/5IwwRokpmrNRvP5Ntbws=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-GO440TtYPEmZHMEFkZcf3w-1; Thu, 16 Nov 2023 11:33:08 -0500
X-MC-Unique: GO440TtYPEmZHMEFkZcf3w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66d120c28afso10871036d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Nov 2023 08:33:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700152387; x=1700757187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2R1YGHbVqaFXfxAjW2H0oaW69e+Pupsv8J1Jh5FYd8=;
        b=Mkqh5iDgJCPgSgOYBg1PnfFhPjRqJDmmzqJKg7NKNkb1G/6HfmcZacqeWU2gaJU4Ad
         +dfbhudzd4wPbqVT1p8U8l9sTlcwMOTRySR08xHvtjXdQhy8r3d/S1gxbG5NnupKjTpg
         NVN6H6svI5/Z7UKVHdWslj4JmeX2+6cPMwdZCZeQNnkfeDNK+51/nahKMs14oiCdOAfw
         /RZKmXat3M2UGmtlKQU0USGjueXrTgzqZClaLGQTl/n7hRPwS8Ad3bSzQRk020xnxER2
         mVIx/nkPFys/a1muvdjfK18ry8QDxqtZHufpmuGnA6NIPz2pE0IOjeu/3JaBQxjUPpQf
         VJtg==
X-Gm-Message-State: AOJu0YyOmhoUlJDqFnzO3c8qsRtQG1+nU0lgfCD6FzETt6YUWa/D27cS
	oofptE2AKo5bXBquIPYB58587wewM0247HoRcgEkDNVte9rpWFCCpDLWUyt5+RenFRtUOxwM8SS
	5xElPsS0oXALkaoXalMCrpt79FpRv
X-Received: by 2002:ad4:4a0c:0:b0:677:a9f8:ffaf with SMTP id m12-20020ad44a0c000000b00677a9f8ffafmr8581053qvz.13.1700152387669;
        Thu, 16 Nov 2023 08:33:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEEgk8pzw41/n4ANf585fqyMlEj86chFUDmRIhAvinjMu1NPYWAuUtx3i3d3vcebD/atvQ1Q==
X-Received: by 2002:ad4:4a0c:0:b0:677:a9f8:ffaf with SMTP id m12-20020ad44a0c000000b00677a9f8ffafmr8581023qvz.13.1700152387376;
        Thu, 16 Nov 2023 08:33:07 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id v12-20020a0cc60c000000b006717ddb4d47sm1465741qvi.28.2023.11.16.08.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 08:33:06 -0800 (PST)
Message-ID: <50d6abd6-111c-4e66-9989-65cb8e43b48c@redhat.com>
Date: Thu, 16 Nov 2023 18:33:02 +0200
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
Cc: workflows@vger.kernel.org, Joe Perches <joe@perches.com>,
 Andy Whitcroft <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>,
 David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
 Veronika Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>,
 kernelci@lists.linux.dev, Chandan Babu R <chandanrlinux@gmail.com>,
 Dave Chinner <david@fromorbit.com>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-3-Nikolai.Kondrashov@redhat.com>
 <20231115185808.GD36211@frogsfrogsfrogs>
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <20231115185808.GD36211@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the comments, Darrick!

On 11/15/23 20:58, Darrick J. Wong wrote:
> On Wed, Nov 15, 2023 at 07:43:50PM +0200, Nikolai Kondrashov wrote:
>> +xfstests
>> +--------
>> +
>> +:Summary: File system regression test suite
>> +:Source: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> You might as well use the https link to the fstests git repo.
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

Sure! Queued for the next version.

>> +:Docs: https://github.com/tytso/xfstests-bld/blob/master/Documentation/what-is-xfstests.md
> 
> Awkardly, this github link is nice for rendering the markdown as html,
> but I think the canonical source of xfstests-bld is also kernel.org:
> 
> https://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git

Alright. Changed to 
https://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git/tree/Documentation/kvm-quickstart.md

And changed the kvm-xfstests docs link to 
https://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git/tree/Documentation/kvm-quickstart.md

>> +kvm-xfstests smoke
>> +------------------
>> +
>> +:Summary: File system smoke tests
>> +:Superset: xfstests
> 
> Source: https://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git
> 
> ?

Well, I wasn't sure what to put here either :D I would defer to you guys in 
this matter.

I'm actually not really sure we need the "Source:" field. I think maybe having 
just the "Docs" (HOWTO) field would less confusing. I.e. just go read the 
docs, they should tell you what and how to get.

I mean you got the sources, and then what? Look for the docs there yourself?

What do you think?

>> +:Docs: https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
>> +
>> +The "kvm-xfstests smoke" is a minimal subset of xfstests for testing all major
>> +file systems, running under KVM.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2565c04f0490e..f81a47d87ac26 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7974,6 +7974,7 @@ L:	linux-ext4@vger.kernel.org
>>   S:	Maintained
>>   W:	http://ext4.wiki.kernel.org
>>   Q:	http://patchwork.ozlabs.org/project/linux-ext4/list/
>> +V:	kvm-xfstests smoke
> 
> I wouldn't mind one of these being added to the XFS entry, though I've
> cc'd the current and past maintainer(s) of XFS for their input.

Sure, just give me a shout when you're ready and I'll add it :D

Thanks!
Nick


