Return-Path: <linux-kselftest+bounces-14158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED71193B4C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 18:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610B11F21B57
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 16:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02C115B10B;
	Wed, 24 Jul 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="owsO/w2x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB12595;
	Wed, 24 Jul 2024 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837951; cv=none; b=aBSobOQFsbUErCtVoJFxanKIQwvwzO6t8cZXee9Ki1qwcKB5L0vcnSy0jHghw5aT/HDMaaEbPUgkmHwWEFZDt0yr7kFUZnYA+AUX2izaA3kIzRtfu1RiDG2Wi2kWtR7Iu1gaheULgQ8rexaMRjmAMHnqyRrFiUUzMmAOP7cGS28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837951; c=relaxed/simple;
	bh=gx6NNdtMHs9YmCR0XmWrLMTU6Qy9w/k18HKfnpKZKCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9d9LizzuGJWoWuBYayHI6R9frQfxEkXCTJLcvhkAtxy06QHNA3Q28zm7NKmIPz3EO/ZIMTCfo+R4NHeV/vaYYoyn/gVKeCGZD4vwAUv7p/PK/A6ZzyBg7o5TCG0ckg3XxrAaLCSUiq3lT86fDat7uYLyQy7QunEWb47xsRA/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=owsO/w2x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OGDlMr009568;
	Wed, 24 Jul 2024 16:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	VXu6pswhYbGt3J2Q30dTbPEMvqF0CMjxRabsro7qGms=; b=owsO/w2xJ3W58HvC
	LjoT6Po7GSbQKJ6AniT1KYiDfJJEFpW7Ypx06c2Zs6vtaFZkR8NJMbzsDB/quG6H
	PLEmwM7sSgzqCg8SkYL89FHSQxKrW3eEOtwiFFx+7DFChSFXIWBKnUsGIQmCqQDK
	m20L6TK9C5bZzIy3m1LJKBzt5C167H9utpUcYF0BhTRaSaOBO2x1jUxl5V1rCMqM
	wEufCEulIt53hFVXQxRaWFJSBPRY+1cpp3iuOs84OgmxwtneqfJZX7FBLddu1VIY
	ozFrZ3HCVbdVTeWu/kZcBDC2MrZZ1Hzvq46azo38Qhgn9EpnAMvZPjAQD0WVocvz
	GgUEiQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40juxbhdvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 16:19:03 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46OGJ3UU020859;
	Wed, 24 Jul 2024 16:19:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40juxbhdvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 16:19:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46ODvmvn009144;
	Wed, 24 Jul 2024 16:19:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gt93hmbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 16:19:02 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46OGIuV251773928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 16:18:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D547320040;
	Wed, 24 Jul 2024 16:18:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DFFC2004B;
	Wed, 24 Jul 2024 16:18:56 +0000 (GMT)
Received: from darkmoore (unknown [9.171.89.145])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 24 Jul 2024 16:18:56 +0000 (GMT)
Date: Wed, 24 Jul 2024 18:18:54 +0200
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah
 Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand
 <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH v2 03/10] selftests: kvm: s390: Add s390x ucontrol test
 suite with hpage test
Message-ID: <20240724181854.3da1f7da.schlameuss@linux.ibm.com>
In-Reply-To: <5df2d680-6d6c-43c8-8b69-e6ad7e4ac35a@linux.ibm.com>
References: <20240723093126.285319-1-schlameuss@linux.ibm.com>
	<20240723093126.285319-4-schlameuss@linux.ibm.com>
	<5df2d680-6d6c-43c8-8b69-e6ad7e4ac35a@linux.ibm.com>
Organization: IBM
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CO9I6M5MS9gSWwVq3ADHhyg8arKbgKiA
X-Proofpoint-GUID: O2CQdJVID2Sycfz6H_80aFohI_8zFKxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_15,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=948 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240112

On Wed, 24 Jul 2024 16:52:00 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 7/23/24 11:31, Christoph Schlameuss wrote:
> > Add test suite to validate the s390x architecture specific ucontrol KVM
> > interface.
> > 
> > Make use of the selftest test harness.
> > 
> > * uc_cap_hpage testcase verifies that a ucontrol VM cannot be run with
> >    hugepages.
> > 
> > To allow testing of the ucontrol interface the kernel needs a
> > non-default config containing CONFIG_KVM_S390_UCONTROL.
> > This config needs to be set to built-in (y) as this cannot be built as
> > module.
> > 
> > Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> > Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---  
> 
> [...]
> 
> > +#include "kselftest_harness.h"
> > +#include "kvm_util.h"
> > +
> > +#include <linux/capability.h>
> > +#include <linux/sizes.h>
> > +
> > +#define SYS_ADMIN_CAP 0x200000  
> 
> This looked suspicious to me.
> Surely this would be available in some form in capability.h since 
> CAP_SYS_ADMIN is something that's regularly checked.
> 
> [...]
> 
> > +
> > +/* so directly declare capget to check caps without libcap */
> > +int capget(cap_user_header_t header, cap_user_data_t data);
> > +
> > +/**
> > + * In order to create user controlled virtual machines on S390,
> > + * check KVM_CAP_S390_UCONTROL and use the flag KVM_VM_S390_UCONTROL
> > + * as privileged user (SYS_ADMIN).
> > + */
> > +void require_ucontrol_admin(void)
> > +{
> > +	struct __user_cap_data_struct data[_LINUX_CAPABILITY_U32S_3];
> > +	struct __user_cap_header_struct hdr = {
> > +		.version = _LINUX_CAPABILITY_VERSION_3,
> > +	};
> > +	int rc;
> > +
> > +	rc = capget(&hdr, data);
> > +	TEST_ASSERT_EQ(0, rc);
> > +	TEST_REQUIRE((data->effective & SYS_ADMIN_CAP) > 0);  
> 
> And in fact capability.h does have defines which hide the magic constant:
> data->effective & CAP_TO_MASK(CAP_SYS_ADMIN)
> 

Yes, thank you, that is much better. Will use that instead and remove
the custom SYS_ADMIN_CAP define above.

> > +
> > +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_UCONTROL));
> > +}
> > +  
> 


