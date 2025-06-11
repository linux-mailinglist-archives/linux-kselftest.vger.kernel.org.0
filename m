Return-Path: <linux-kselftest+bounces-34771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C4EAD61C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 23:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14E6188B2AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 21:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FE0244669;
	Wed, 11 Jun 2025 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="zLEjSVtS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A718E1FFC54;
	Wed, 11 Jun 2025 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678315; cv=none; b=axdyTKkxTlU4uvu/xAXvxfVQXuLnspNONKBP85UEW0FynjfualiLxAfe+11MySxnRxsd6pmui3WnycquUDzhUiUw9HI9QHFXDSLZnFANy9wQWb6OciK5agi8VRyzHjxv39Wp3MftY1jqWlcjTeawPDZ52w0/heygvROYrMeIT3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678315; c=relaxed/simple;
	bh=nqRO5OgebVyWIVOI2XgZ/jMVe1jj36qOOjMKRb8BlyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OeFhgMJ21ak/rMvE2WHQTJA5SbCJBa1/T4MdHmC0flBPrxr/nbtPvAqAs7Z7Yo3/HWYxbewN5lZ6l1MTarS4iQOQHYuDiQiRH7DUU5FVxqkosQ7ykd9QICTuWuIOThu9hYpdYm0HA2IHEi1tyZhqHXYoAx3iaj/XH3ElewfL+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=zLEjSVtS; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BKuhkN023871;
	Wed, 11 Jun 2025 21:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=M6eB7MOK4OEpwU3dAcNFsfMvjjyTtN+xja+AsNl5g44=; b=zLEj
	SVtSK4TrHPJM0lt3e/3g2337w90IU+bXGurNwyHguwm5hh/RIGJVtVWekvEARze4
	ytc13nylu4rjE+SfYc5PnSt/Iv2dPx9OFdUnbASBZsCLSLkj1wpjN3l+vUwPUZkY
	QSiE2hDe9cY9Ivnq8iymVgRbnArK4t8jFtkZZfV6N1+KR743Pj154B6zG4mcuD3g
	pJpL0g5KLPToYLqnKXudQoK3P7O0BKMU5iTEb5T8NYzGo1+J//V2YWvmFMW5jS/i
	5gAU687G6iIl9A4ES/RKqBxFis8SkG9s+lGqNQ6G7KFXze35ZxBdXWzbKxNRd8zB
	JyGlc9t/I9snb62Wfg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 476ps7resm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 21:39:55 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH007.crowdstrike.sys (10.100.11.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Jun 2025 21:39:50 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <qmo@kernel.org>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <eddyz87@gmail.com>, <haoluo@google.com>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <justin.deschamp@crowdstrike.com>, <kpsingh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mark.fontana@crowdstrike.com>, <martin.lau@linux.dev>,
        <mykolal@fb.com>, <sdf@fomichev.me>, <shuah@kernel.org>,
        <slava.imameev@crowdstrike.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add test for bpftool access to read-only protected maps
Date: Thu, 12 Jun 2025 07:39:47 +1000
Message-ID: <20250611213947.21534-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <aaa49f30-d571-4c7e-8135-691252ebc3c2@kernel.org>
References: <aaa49f30-d571-4c7e-8135-691252ebc3c2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH007.crowdstrike.sys (10.100.11.74)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: CnKjQ_HD441G03lCLB0FU1hd5XguhixQ
X-Proofpoint-GUID: CnKjQ_HD441G03lCLB0FU1hd5XguhixQ
X-Authority-Analysis: v=2.4 cv=OeyYDgTY c=1 sm=1 tr=0 ts=6849f7ab cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=6IFa9wvqVegA:10 a=47lfzmhVyG3JbEG8tnMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE4MyBTYWx0ZWRfXwl0j1zkJzs7+
 TpuuuLdNhMOZT2PXJRxiPXs61OMK7l7ziPy3cCJMsKncnrnpJ6P+aejJJVbr3coCH+PABQweB7m
 FhxDXc/UcC2JFoO/3/wLwlv97zqH1aryCef5n1jPmySROWSFKw03eCeW8xbJFwC0FU4LyiG7aAA
 pbG/2Y89tG3l8ssHb7z5x4T6PPUpuqI4tBKGDd2bo4R2UIpEcSHHak2bCToNQKYVxp2VJvTjBj2
 Q9SUc5rwI/xU8+N7fZ1M9LdKhwjRzQMDB+FkZEnJ4vGL0nacvhX58ThthSyrVz7cCxjgFdKHT0S
 gtwE+waOdlquDpoEu/HdgWHwhlZH7AMt9g/fX/BnMuUt3kgGbh31KVm2EvG2dIL/JY72nCeldn4
 dI7fXwZ0UD50KZfmLf/xp1K1a3oZ94a6biB25xqb4VgCtvlRdX2dNlBh4wsUSZEYUSrm3ThH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=682 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110183

> > +	make -C tools/bpf/bpftool -s -j"$ncpus" OUTPUT="$output_dir"/ >/dev/null
> > +	echo ... finished building bpftool
> > +	cd "$pwd"
> > +}
>
>
> Given that you're reusing the BPF selftests infra, you shouldn't have to
> rebuild bpftool as part of the test. It's already built from the
> Makefile, and other tests just assume it's available already (see
> test_bpftool.py, test_bpftool.sh).


Agree, the build step will be removed for v3.


> > +	# Test write access to the map
> > +	if "$bpftool_path" map update name "$map_name" key $key value $value; then
> > +		if [ "$write_should_succeed" = "true" ]; then
> > +			echo "  Write access to $map_name succeeded as expected"
> > +		else
> > +			echo "  Write access to $map_name succeeded but should have failed"
> > +			exit 1
> > +		fi
> > +	else
> > +		if [ "$write_should_succeed" = "true" ]; then
> > +			echo "  Write access to $map_name failed but should have succeeded"
> > +			exit 1
> > +		else
> > +			echo "  Write access to $map_name failed as expected"
> > +		fi
> > +	fi
> 
> 
> Can we try to delete an item as well, please?

I added an item deletion test to v3.

> > +
> > +	# Pin the map to the BPF filesystem
> > +	"$bpftool_path" map pin name "$map_name" "$pin_path"
> > +	if [ -e "$pin_path" ]; then
> > +		echo "  Successfully pinned $map_name to $pin_path"
> > +	else
> > +		echo "  Failed to pin $map_name"
> > +		exit 1
> > +	fi
> > +
> > +	# Test read access to the pinned map
> > +	if "$bpftool_path" map lookup pinned "$pin_path" key $key; then
> > +		echo "  Read access to pinned $map_name succeeded"
> > +	else
> > +		echo "  Read access to pinned $map_name failed"
> > +		exit 1
> > +	fi
> > +
> > +	# Test write access to the pinned map
> > +	if "$bpftool_path" map update pinned "$pin_path" key $key value $value; then
> > +		if [ "$write_should_succeed" = "true" ]; then
> > +			echo "  Write access to pinned $map_name succeeded as expected"
> > +		else
> > +			echo "  Write access to pinned $map_name succeeded but should have failed"
> > +			exit 1
> > +		fi
> > +	else
> > +		if [ "$write_should_succeed" = "true" ]; then
> > +			echo "  Write access to pinned $map_name failed but should have succeeded"
> > +			exit 1
> > +		else
> > +			echo "  Write access to pinned $map_name failed as expected"
> > +		fi
> > +	fi
> 
> 
> Maybe refactor lookup/update as a function that you can call before and
> after pinning the map? (I don't mind much.)


I changed it as suggested for v3.


> > +check_bpffs() {
> > +	if [ -z "$BPF_FS" ]; then
> > +		echo "Could not run test without bpffs mounted"
> 
> 
> Why not? Bpftool will attempt to mount it for you if it's not available
> (create_and_mount_bpffs_dir()).
> 
> You could mount it manually to a specific location and unmount it during
>  the clean-up phase, if you wanted to be sure that the test doesn't have
> any side effect on the filesystem.


I made changes as suggested for v3.


> > +# Load and attach the BPF programs to control maps access
> > +"$BPFTOOL_PATH" prog loadall "$BPF_FILE_PATH" "$BPF_DIR"/prog autoattach
> > +
> > +# Test protected map (write should fail)
> > +test_map_access "$PROTECTED_MAP_NAME" "false" "$BPFTOOL_PATH" "$BPF_DIR"
> > +
> > +# Test not protected map (write should succeed)
> > +test_map_access "$NOT_PROTECTED_MAP_NAME" "true" "$BPFTOOL_PATH" "$BPF_DIR"
> 
> 
> We could also test map creation here (possibly even with inner maps).

I added a test for map-of-maps creation for v3.



