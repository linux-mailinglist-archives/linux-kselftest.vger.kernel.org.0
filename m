Return-Path: <linux-kselftest+bounces-45662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90221C5E857
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 18:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3343420A2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 17:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB31C2D5A01;
	Fri, 14 Nov 2025 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mvpa56aB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44452D5432;
	Fri, 14 Nov 2025 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140881; cv=none; b=nWSrwOyXpYL1bti21KaE+izZDuLShV3HCrMo6IwWSYwfseeLEGt+NVcjv3X7jwFjkySiM0y1FKrPfrkFN1TQ2C+X2n0TJafNikxw0FNk6uN/TcE3mrjL4IHLIwThqOIv/NU6NSGNuKLBInoMYmwc/oeosyILP5e3xTwTHVQ1jYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140881; c=relaxed/simple;
	bh=JVMpqOWcLMFCAWU33olBZTr+K7wf1Is8jZBAtaqK55Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jt7bxzYjD4s+D6QgNTO+j5IZxwILbcOlmQVz9wM1EBh7QgoeegsUhctroqcuKxo59BYq3D6bawHWnF9iZ692ZrUId1EnMhYxYvA+Wgpm1eUOXyN7rvVvWA9rcNMsTYlPxJD/mkt4R6oU8CdNhv87U6hhEG7Rk1R0pBjnl0SHy2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mvpa56aB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEDmiEj029027;
	Fri, 14 Nov 2025 17:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=P2Nm6Onw0q8fHzAEfmXvyG5IXHnkvj
	b10mJ/VAqkb3Q=; b=Mvpa56aBX/l9Glh810ag3gV6Fy7Bym1IJzWjuviNZ5SNdg
	SM0j4sLV6IYc6d+aWnJQrgFzVFXx6Ne9B/cJfWhskV5Hu1bYCSid8n3x0Qw/MHLf
	4irsnF1A+gSrGdUk33/iJJj14jEmtwjFf9QaSjp2tseluRqAp1NRW6CQyI9zhJJS
	G2oj9QLfYQNDRbWBE0EQjfAaCCjxu7HDRuO5Mw6gpDEh7+tRemv25ZDdrfz3Mrw/
	hzT2yMPJdo56zJAJ20/D9GrwbOQZisGCUMiwTwCfdlcJVeHiaZInk6GDYeIsxwdX
	BweOTctQeJArioYMSP5FnX9kw7CfX/LfNkdDY9nQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4adree3t48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 17:19:54 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AEHFf0S026695;
	Fri, 14 Nov 2025 17:19:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4adree3t43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 17:19:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEG2iFw004748;
	Fri, 14 Nov 2025 17:19:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aagjycpp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 17:19:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AEHJnXQ38339028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 17:19:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26BE520043;
	Fri, 14 Nov 2025 17:19:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D70820040;
	Fri, 14 Nov 2025 17:19:39 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.106.27])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Nov 2025 17:19:39 +0000 (GMT)
Date: Fri, 14 Nov 2025 22:49:35 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, hbathini@linux.ibm.com,
        sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
        eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
        martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix
 htab_update/reenter_update selftest failure
Message-ID: <aRdkp7ztSM1JNZME@linux.ibm.com>
References: <20251114152653.356782-1-skb99@linux.ibm.com>
 <3b15cc4d71bfa87ffcd49f69c1453d88c6457ef0c9c312c11b8a550f862e8f2b@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b15cc4d71bfa87ffcd49f69c1453d88c6457ef0c9c312c11b8a550f862e8f2b@mail.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OSBTYWx0ZWRfX5dJT8FhEp3G7
 pRYU/5oPDzqqYE7N59JDoMbV3e5dbqgf+UPECycscxPZ94oeFT8oB3hrGjAAtG/kxAKBoDbFV6r
 1Li92Juu3s3GFgnfwNQ9z7hdcm51f645wgcioxfTWokww0kxSzosoFVaiGhuZk8kbAzSx3VLDqf
 PdYR9oT1JdvYr8OhkPqEbG6eUZK5d02G3KnOvm0PNbj/RS+qQQRKFyUFX8ylcDNnqPuIPESbDQj
 XTCQtgaQRDxvEu81P0UsikcbGbItmn4Pv6dnMZOg/x0ItFMiPLekmQqokm+1Upr5myAdFdqP/lV
 EEbkgG2j2XIzu11YU1b6FCtX+xwuF5a6d8MZTbuFMGMeRDmlTIZCEcXqzipZZdxrGxGQKDxV6BX
 ztC9AUdMdtrRZ35Yp5cRAl6qYbOVYQ==
X-Proofpoint-ORIG-GUID: pqaLkmWo8Etjl-kk7Y2e8IxlrwyVcFDJ
X-Proofpoint-GUID: yK6CtMW2pTuKf1YjF4kzwejkSzk1fPmb
X-Authority-Analysis: v=2.4 cv=J/GnLQnS c=1 sm=1 tr=0 ts=691764ba cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=NrwLQqnjwQ5ZMmIj2uUA:9
 a=CjuIK1q_8ugA:10 a=bA3UWDv6hWIuX7UZL3qL:22 a=yULaImgL6KKpOYXvFmjq:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511130179

On Fri, Nov 14, 2025 at 03:50:44PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > index 2bc85f481..96b65c1a3 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > @@ -15,17 +15,17 @@ struct htab_update_ctx {
> >  static void test_reenter_update(void)
> >  {
> >  	struct htab_update *skel;
> > -	unsigned int key, value;
> > +	void *value = NULL;
> > +	unsigned int key, value_size;
>                            ^^^
> 
> Is key supposed to be initialized? The old code had 'unsigned int key = 0,
> value = 0;' but the new code drops the initialization. Later uses of key
> at the bpf_map_update_elem() calls will pass uninitialized stack memory.
> 
> >  	int err;
> >
> >  	skel = htab_update__open();
> >  	if (!ASSERT_OK_PTR(skel, "htab_update__open"))
> >  		return;
> 
> [ ... ]
> 
> > @@ -33,14 +33,32 @@ static void test_reenter_update(void)
> >  	if (!ASSERT_OK(err, "htab_update__attach"))
> >  		goto out;
> >
> > -	/* Will trigger the reentrancy of bpf_map_update_elem() */
> > -	key = 0;
> > -	value = 0;
> > -	err = bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, &value, 0);
> > -	if (!ASSERT_OK(err, "add element"))
> > +	value_size = bpf_map__value_size(skel->maps.htab);
> > +
> > +	value = calloc(1, value_size);
> > +	if (!ASSERT_OK_PTR(value, "calloc value"))
> > +		goto out;
> > +	/*
> > +	 * First update: plain insert. This should NOT trigger the re-entrancy
> > +	 * path, because there is no old element to free yet.
> > +	 */
> > +	err = bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, &value, BPF_ANY);
> > +	if (!ASSERT_OK(err, "first update (insert)"))
> > +		goto out;
> > +
> > +	/*
> > +	 * Second update: replace existing element with same key and trigger
> > +	 * the reentrancy of bpf_map_update_elem().
> > +	 * check_and_free_fields() calls bpf_obj_free_fields() on the old
> > +	 * value, which is where fentry program runs and performs a nested
> > +	 * bpf_map_update_elem(), triggering -EDEADLK.
> > +	 */
> > +	memset(&value, 0, sizeof(value));
>                ^^^^^^^
> 
> Does this memset zero the allocated memory? It looks like this zeros the
> pointer variable itself (8 bytes) rather than the memory it points to.
> Should this be 'memset(value, 0, value_size)' instead?
> 
> > +	err = bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, &value, BPF_ANY);
> > +	if (!ASSERT_OK(err, "second update (replace)"))
> >  		goto out;
> >
> > -	ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy");
> > +	ASSERT_EQ(skel->bss->update_err, -EDEADLK, "no reentrancy");
> >  out:
> >  	htab_update__destroy(skel);
> >  }
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19369517166
Will fix these.


