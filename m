Return-Path: <linux-kselftest+bounces-47699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 322CBCCB3FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 10:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21CF33015DFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02112E8E16;
	Thu, 18 Dec 2025 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mHIfhZVX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C792F290B;
	Thu, 18 Dec 2025 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051261; cv=none; b=mKiqkhEj4LIIThe1Z7zQlARmnmLryk8ZlE0sTzO4LjcLgv2trwqmsqU2W7B6MZPi0TIVPFhZ2d/zWmx1kxA73H060a/x+tvTT1B+RciFx8k+ITcbe6Ep+DgqaoyPpGRl7L6X8ky+ct8RUZMGhlxSwbYwS2E4luwhbsg2QK3Bl5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051261; c=relaxed/simple;
	bh=h33y4hbjE/yK5zDtWppgf3q+75BLE98tD/FB851VB6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlWf30qwrHrxRkRcAnzXBiklVzS8SuM61ZfvHXTl3+RhRw2O1hM2UR1xiGeLg1kaE3ItCi3AxJPZfbNRZXLQn41RNX+HPJFFtOtnn4P4hlpSmYmS2tneMifUCWiJg0xSEeQ7RGn/cxgFJaLHdd5Byd5qvGrdOOOk4SG17LLjCAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mHIfhZVX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BI83Yw4029519;
	Thu, 18 Dec 2025 09:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Dk8Ptj
	3Xy6YchdK2QJF9oQ5tyjemTSxSIz8H4FcoAzI=; b=mHIfhZVXpERsBaQjPhWViW
	71gU/7ps1TtcOToUtzPAYBnawT/Kv/MAWtU/1amhD983G63HsaG7YLFJ8Cdcc4Lb
	m2X26j3uIhFEqksSmueue/aBWhhLPYZofWDZP7BNh7VZ5UGS3KliExj9nhFiu5zP
	u2TtDKShH+Se9EC0gRgOFHcT8GDSDEQo9ZAX67+WmC/DBcxfFdgyRbJoc4hOMxTX
	NtzSj8OARTVNDiet58RjLHHVD/ZYjxWo7LEn/pZSYweqpuECkVcA7RNn8eYxhZmY
	i0IdSKAd4F9o0WNME2porKi54gAESAlm3fl9vYx04HqnKUeNhQT1GZ9/FY7etfuQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1rue8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 09:47:23 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BI9lNvG020810;
	Thu, 18 Dec 2025 09:47:23 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1rue4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 09:47:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BI67JTJ012806;
	Thu, 18 Dec 2025 09:47:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1juyfs4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 09:47:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BI9lKYj42467684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 09:47:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CC4420040;
	Thu, 18 Dec 2025 09:47:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBDBE20043;
	Thu, 18 Dec 2025 09:47:18 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.77])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Dec 2025 09:47:18 +0000 (GMT)
Date: Thu, 18 Dec 2025 15:17:16 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: David Gow <davidgow@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <raemoar63@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Issue in parsing of tests that use KUNIT_CASE_PARAM
Message-ID: <aUPNpGgj3hmA3aZL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aULJpTvJDw9ctUDe@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aUOrH1iapKnOaZEj@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <CABVgOSk5UJf00=uEsk4chEJpKoPeYqXbk+czM7ipoD_0eWiedg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVgOSk5UJf00=uEsk4chEJpKoPeYqXbk+czM7ipoD_0eWiedg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hEZX4sTgMlBc2ouBxVUhb28OFT0DpkS4
X-Proofpoint-ORIG-GUID: x3IXlC57UPw1hDdLoufWAsT5DMm1-h-A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX/VL9gTHPP/s+
 UtHglhyGu+6ayokCMoJdgEIptlbxOgea50TRqdKwSTh6Z19tzDqpd/OT7CZ7QVRxmEOGfSkKkXH
 hZsTl8sk1iPYPkNag303HWUgIP1dHI/gJHr9dVVotOz+I9lHG58FLeJ8SqVVGRrmTtiRrNktca1
 WxKWZqcs1McDiXJxhhEfWjBaHuvMOiXfvwlIGnWiyChAz6GbhTdpknhBn42sC+Bg5x+ihLFZsGV
 nITqdruH8m4wxdPp8PCZynFcS0RTgV3s40I24M7gEleHAKQYeKK95vut7GIcrqE1pqAhKXAl2Og
 NhhJi5PZINHUma0CnyEp3lW9aicQPKIi9Ej2Kfd3nOPYbPFpHsTNjLWAEUM62Jx3iyXsSboBeRB
 PGsgdWVDA3k2HKYUYEByCTfwkFQEVg==
X-Authority-Analysis: v=2.4 cv=L/MQguT8 c=1 sm=1 tr=0 ts=6943cdab cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=iOYrec4HztlP848Y7-MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023

On Thu, Dec 18, 2025 at 04:58:33PM +0800, David Gow wrote:
> On Thu, 18 Dec 2025 at 15:20, Ojaswin Mujoo <ojaswin@linux.ibm.com> wrote:
> >
> > On Wed, Dec 17, 2025 at 08:47:57PM +0530, Ojaswin Mujoo wrote:
> > > Hello,
> > >
> > > While writing some Kunit tests for ext4 filesystem, I'm encountering an
> > > issue in the way we display the diagnostic logs upon failures, when
> > > using KUNIT_CASE_PARAM() to write the tests.
> > >
> > > This can be observed by patching fs/ext4/mballoc-test.c to fail
> > > and print one of the params:
> > >
> > > --- a/fs/ext4/mballoc-test.c
> > > +++ b/fs/ext4/mballoc-test.c
> > > @@ -350,6 +350,8 @@ static int mbt_kunit_init(struct kunit *test)
> > >         struct super_block *sb;
> > >         int ret;
> > >
> > > +       KUNIT_FAIL(test, "Failed: blocksize_bits=%d", layout->blocksize_bits);
> > > +
> > >         sb = mbt_ext4_alloc_super_block();
> > >         if (sb == NULL)
> > >                 return -ENOMEM;
> > >
> > > With the above change, we can observe the following output (snipped):
> > >
> > > [18:50:25] ============== ext4_mballoc_test (7 subtests) ==============
> > > [18:50:25] ================= test_new_blocks_simple  ==================
> > > [18:50:25] [FAILED] block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> > > [18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
> > > [18:50:25] Failed: blocksize_bits=12
> > > [18:50:25] [FAILED] block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> > > [18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
> > > [18:50:25] Failed: blocksize_bits=16
> > > [18:50:25] [FAILED] block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> > > [18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
> > > [18:50:25] Failed: blocksize_bits=10
> > > [18:50:25]     # test_new_blocks_simple: pass:0 fail:3 skip:0 total:3
> > > [18:50:25] ============= [FAILED] test_new_blocks_simple ==============
> > > <snip>
> > >
> > > Note that the diagnostic logs don't show up correctly. Ideally they
> > > should be before test result but here the first [FAILED] test has no
> > > logs printed above whereas the last "Failed: blocksize_bits=10" print
> > > comes after the last subtest, when it actually corresponds to the first
> > > subtest.
> > >
> > > The KTAP file itself seems to have diagnostic logs in the right place:
> > >
> > > KTAP version 1
> > > 1..2
> > >     KTAP version 1
> > >     # Subtest: ext4_mballoc_test
> > >     # module: ext4
> > >     1..7
> > >         KTAP version 1
> > >         # Subtest: test_new_blocks_simple
> >
> > So looking into this a bit more and comparing the parameterized output
> > with non parameterized output, I'm seeing that the difference is that
> > output via KUNIT_CASE_PARAM is not printing the test plan line right
> > here. This plan sort of serves as divider between the parent and the 3
> > children's logs and without it our parsing logic gets confused. When I
> > manually added a "1..3" test plan I could see the parsing work correctly
> > without any changes to kunit_parser.py.
> >
> 
> Thanks for looking into this!
> 
> There's been a bit of back-and-forth on how to include the test plan
> line for the parameterised tests: it's not always possible to know how
> many times a test will run in advance if the gen_params function is
> particularly complicated.
> 
> We did have a workaround where array parameters would record the array
> size, but there were a couple of tests which were wrapping the
> gen_params function to skip / add entries which weren't in the array.
> 
> One "fix" would be to use KUNIT_CASE_PARAM_WITH_INIT() and have an
> init function which calls kunit_register_params_array(), and then use
> kunit_array_gen_params() as the generator function: this has an escape
> hatch which will print the test plan.
> 
> Otherwise, as a hack, you could effectively revert
> https://lore.kernel.org/linux-kselftest/20250821135447.1618942-2-davidgow@google.com/
> — which would fix the issue (but break some other tests).
> 
> Going through and fixing this properly has been on my to-do list; with
> some combination of fixing tests which modify the gen_params function
> and improving the parsing to better handle cases without the test
> plan.
> 
> Cheers,
> -- David

Hi David,

Thanks for the workaround, KUNIT_CASE_PARAM_WITH_INIT() did the trick!

So I'm just wondering if it makes sense to still have a placeholder test
plan line in cases we can't determine the number of tests. I think something
like 1..X should be enough to not throw off the parsing. (Although I
think this might not be exactly compliant to KTAP).

Regards,
ojaswin

> 
> > >     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
> > > Failed: blocksize_bits=10
> > >         not ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> > >     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
> > > Failed: blocksize_bits=12
> > >         not ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> > >     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
> > > Failed: blocksize_bits=16
> > >         not ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> > >     # test_new_blocks_simple: pass:0 fail:3 skip:0 total:3
> > >     not ok 1 test_new_blocks_simple
> > >     <snip>
> > >
> > > By tracing kunit_parser.py script, I could see the issue here is in the
> > > parsing of the "Subtest: test_new_blocks_simple". We end up associating
> > > everything below the subtest till "not ok 1 block_bits=10..." as
> > > diagnostic logs of the subtest, while these lons actually belong to the
> > > first of the 3 subtests under this test.
> > >



