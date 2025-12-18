Return-Path: <linux-kselftest+bounces-47701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CAFCCB7E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 11:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 005153014D81
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 10:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A073128CC;
	Thu, 18 Dec 2025 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GdZKhxKP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251012E9733;
	Thu, 18 Dec 2025 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054847; cv=none; b=gce5RPQz06Qw8U+HkPKdZE063ostJdZ+4DB7dgQElkP+t2KrFN8u7ubZGijr+pOzbKdj5PC85WzEO6NzRQVWMXd/yBoxAmcCqs//pKkf0daAiz6T7GAEajV6H+UHP2h9y+/Q6q94f9fJSW9NR4tgEbN+2LbNbl4TIPvloASRgWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054847; c=relaxed/simple;
	bh=+J6VrrKvxzlI0Qhs/yCUMpA1jxf2mJiO5nM2Rzsh4mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtnYJC/SVbhPSqEW9Uqosc3cH4N3i5WN8iSwcroaoBJv9WGxzMRaawBtvM4Wxk5vx3n0Sy8MLL7sIdJB8z03C9v7L9n8CI2QTgtBouZtggR6SFCowKnCFmEPtX9T3Po6/YRRNYdnjgnirpHzPpYxkUOlekH68UVIxzL3YRZwuQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GdZKhxKP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BI8mRkW022697;
	Thu, 18 Dec 2025 10:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=h7nffq
	VuISrVST5s4ERHAccrCz5obk5Y06TTgoLbaBo=; b=GdZKhxKP9dGMPRXuZUXYfi
	Z+7XtdiuV+0fumLxedbt3dz7XPCQv3Xm3Fg80Atlz0TFrLxc5oNYaxbXYcXlGU/2
	EjLCi/XvVXd5gOya+7x+zhY5Gv6mBi5TEFg7yrZo/MUZmgtBD1yMciNBUNkV0ezN
	FddF0jmz3sPOe5cZBWRENhSomWIKexGm9kt22r0xnkXnCvvpYgYcT2IyHItyKon/
	xWea1oDTtHXk54u+c8nTE6OHqhcsUdUc7z5dhKdtimxYOKaszYNaKtn3GI+68y4q
	LzRUuyO11nCkjRxjoq/0ISka2elDqhdEi+4VGD4XXXB0wSd4QaTyLXi114wD++/A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytvj3a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 10:46:07 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BIAk6qq025324;
	Thu, 18 Dec 2025 10:46:06 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytvj3a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 10:46:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BI7X9BG003064;
	Thu, 18 Dec 2025 10:46:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1kykypup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 10:46:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BIAk3Wo55247348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 10:46:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9167E2004B;
	Thu, 18 Dec 2025 10:46:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AA2A20043;
	Thu, 18 Dec 2025 10:46:02 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.77])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Dec 2025 10:46:02 +0000 (GMT)
Date: Thu, 18 Dec 2025 16:16:00 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: David Gow <davidgow@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <raemoar63@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Issue in parsing of tests that use KUNIT_CASE_PARAM
Message-ID: <aUPbaCU-w_SI5ezq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aULJpTvJDw9ctUDe@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aUOrH1iapKnOaZEj@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <CABVgOSk5UJf00=uEsk4chEJpKoPeYqXbk+czM7ipoD_0eWiedg@mail.gmail.com>
 <aUPNpGgj3hmA3aZL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <CABVgOSkmd2K83WqvRZePzVEbB4kZmBdLO-yTuqoZjz-+YdmaAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVgOSkmd2K83WqvRZePzVEbB4kZmBdLO-yTuqoZjz-+YdmaAg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX1T8QRE7DGkqK
 iNYOP+sMH41Xa6kDCfSuEApakRCHPK29vi9khOMmdmEIDm/Q/HSO9/4vXtQKma+A4WU2rfREFkB
 fljof1xdihn3dPhESmGVDmyvPQb2GZMX9fb81Rf4PgY/sEbWGFjVWgVaSuN6qLwvyfBW5FDEFN3
 wWCOpzOdXTpPLyXsNRc01Ii6fkc7vmTcpW6R+zJrNVmduvcdcLSCx715jqnDysJ5j4zCaiiP9Iw
 EbNJUzjO4kcDGn76P/XDzKc2AMat8QRplrYInSAintzpyvaAYXoh5MuMznDL7dbv3dhuzLpCrE7
 VqQtcKP1KBY1wJ10OYQ7I9g9GLpP14uIY4fVith3VWoQp2HVqky5b+zy3NRWCGl3YqjNNAILAda
 cjtHUKCMjnDSFzxfnyvqxKo610Y6zQ==
X-Proofpoint-ORIG-GUID: 9CaPX65IyzPF-U35H22hZfpirz_tTcMi
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=6943db6f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=07d9gI8wAAAA:8 a=VnNF1IyMAAAA:8
 a=ERvZ9_xW7u35jqeY_7oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-GUID: k8zU0rXM6PreY7IbafpXsSNvuX16m-Kd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023

On Thu, Dec 18, 2025 at 06:15:31PM +0800, David Gow wrote:
> On Thu, 18 Dec 2025 at 17:47, Ojaswin Mujoo <ojaswin@linux.ibm.com> wrote:
> >
> > On Thu, Dec 18, 2025 at 04:58:33PM +0800, David Gow wrote:
> > > On Thu, 18 Dec 2025 at 15:20, Ojaswin Mujoo <ojaswin@linux.ibm.com> wrote:
> > > >
> > > > On Wed, Dec 17, 2025 at 08:47:57PM +0530, Ojaswin Mujoo wrote:
> > > > > Hello,
> > > > >
> > > > > While writing some Kunit tests for ext4 filesystem, I'm encountering an
> > > > > issue in the way we display the diagnostic logs upon failures, when
> > > > > using KUNIT_CASE_PARAM() to write the tests.
> > > > >
> > > > > This can be observed by patching fs/ext4/mballoc-test.c to fail
> > > > > and print one of the params:
> > > > >
> > > > > --- a/fs/ext4/mballoc-test.c
> > > > > +++ b/fs/ext4/mballoc-test.c
> > > > > @@ -350,6 +350,8 @@ static int mbt_kunit_init(struct kunit *test)
> > > > >         struct super_block *sb;
> > > > >         int ret;
> > > > >
> > > > > +       KUNIT_FAIL(test, "Failed: blocksize_bits=%d", layout->blocksize_bits);
> > > > > +
> > > > >         sb = mbt_ext4_alloc_super_block();
> > > > >         if (sb == NULL)
> > > > >                 return -ENOMEM;
> > > > >
> > > > > With the above change, we can observe the following output (snipped):
> > > > >
> > > > > [18:50:25] ============== ext4_mballoc_test (7 subtests) ==============
> > > > > [18:50:25] ================= test_new_blocks_simple  ==================
> > > > > [18:50:25] [FAILED] block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> > > > > [18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
> > > > > [18:50:25] Failed: blocksize_bits=12
> > > > > [18:50:25] [FAILED] block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> > > > > [18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
> > > > > [18:50:25] Failed: blocksize_bits=16
> > > > > [18:50:25] [FAILED] block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> > > > > [18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
> > > > > [18:50:25] Failed: blocksize_bits=10
> > > > > [18:50:25]     # test_new_blocks_simple: pass:0 fail:3 skip:0 total:3
> > > > > [18:50:25] ============= [FAILED] test_new_blocks_simple ==============
> > > > > <snip>
> > > > >
> > > > > Note that the diagnostic logs don't show up correctly. Ideally they
> > > > > should be before test result but here the first [FAILED] test has no
> > > > > logs printed above whereas the last "Failed: blocksize_bits=10" print
> > > > > comes after the last subtest, when it actually corresponds to the first
> > > > > subtest.
> > > > >
> > > > > The KTAP file itself seems to have diagnostic logs in the right place:
> > > > >
> > > > > KTAP version 1
> > > > > 1..2
> > > > >     KTAP version 1
> > > > >     # Subtest: ext4_mballoc_test
> > > > >     # module: ext4
> > > > >     1..7
> > > > >         KTAP version 1
> > > > >         # Subtest: test_new_blocks_simple
> > > >
> > > > So looking into this a bit more and comparing the parameterized output
> > > > with non parameterized output, I'm seeing that the difference is that
> > > > output via KUNIT_CASE_PARAM is not printing the test plan line right
> > > > here. This plan sort of serves as divider between the parent and the 3
> > > > children's logs and without it our parsing logic gets confused. When I
> > > > manually added a "1..3" test plan I could see the parsing work correctly
> > > > without any changes to kunit_parser.py.
> > > >
> > >
> > > Thanks for looking into this!
> > >
> > > There's been a bit of back-and-forth on how to include the test plan
> > > line for the parameterised tests: it's not always possible to know how
> > > many times a test will run in advance if the gen_params function is
> > > particularly complicated.
> > >
> > > We did have a workaround where array parameters would record the array
> > > size, but there were a couple of tests which were wrapping the
> > > gen_params function to skip / add entries which weren't in the array.
> > >
> > > One "fix" would be to use KUNIT_CASE_PARAM_WITH_INIT() and have an
> > > init function which calls kunit_register_params_array(), and then use
> > > kunit_array_gen_params() as the generator function: this has an escape
> > > hatch which will print the test plan.
> > >
> > > Otherwise, as a hack, you could effectively revert
> > > https://lore.kernel.org/linux-kselftest/20250821135447.1618942-2-davidgow@google.com/
> > > — which would fix the issue (but break some other tests).
> > >
> > > Going through and fixing this properly has been on my to-do list; with
> > > some combination of fixing tests which modify the gen_params function
> > > and improving the parsing to better handle cases without the test
> > > plan.
> > >
> > > Cheers,
> > > -- David
> >
> > Hi David,
> >
> > Thanks for the workaround, KUNIT_CASE_PARAM_WITH_INIT() did the trick!
> >
> > So I'm just wondering if it makes sense to still have a placeholder test
> > plan line in cases we can't determine the number of tests. I think something
> > like 1..X should be enough to not throw off the parsing. (Although I
> > think this might not be exactly compliant to KTAP).
> >
> Hmm… that could be a good idea as something to add to KTAPv2.
> 
> One other option might be to use the proposed KTAP metadata's
> :ktap_test: line as a way of delimiting tests in the parser:
> https://lwn.net/ml/all/20251107052926.3403265-4-rmoar@google.com/

Ohh, nice that can also be a good idea.

> 
> In the meantime, I'm going to look into if we can update all of the
> tests using KUNIT_ARRAY_PARAM() with modified gen_params, so we can
> get the correct test plan in most cases.

Sure, thanks for looking into this issue and providing a quick
workaround!

Regards,
ojaswin

> 
> Cheers,
> -- David



