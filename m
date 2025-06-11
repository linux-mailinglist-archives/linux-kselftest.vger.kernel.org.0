Return-Path: <linux-kselftest+bounces-34773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31752AD61E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 23:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FAD1891B6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 21:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AE7248880;
	Wed, 11 Jun 2025 21:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="jUf+PHhC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3B247DF9;
	Wed, 11 Jun 2025 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678581; cv=none; b=qHF8hKI9oyWkGxiCKRpzIcXR7bNDpVkgxi2jXWV7izp/Y3blWDoDfrgrOS2zH+CpLf8XhjO8FIlRspbrQHmWG1SMVhrKhj3IhtX4FL7OUlenZ3I7Jey6VOXDvn4/5AgYhUZuEEX1L33koksgDY/nVHg/j4NPJgT66flE5pRDTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678581; c=relaxed/simple;
	bh=OtDz+EVCzM/AZL6dZm9vgoBTwCYbhlzoU3pVGOM3SQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDbzNzSdzn4H5kmYAky5VQ/nWdVs2ZcCodfYKT6/+OIZeB86s47tUV69eEmf19lpFf2x4JXBHPD74Z0bXIitFv6G/9jm3mGGg3/kCN4/GAb7tKF91L14bdggyaVAZlAkgSUZv7qPDlI2E+RoHRRYo6Se7MRzoFVVUujTk7IyVAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=jUf+PHhC; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BGUBYc023981;
	Wed, 11 Jun 2025 21:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=SnGev3U/yD8kg9SDWZeTHMimn/M3rVYK94ITsbFxIR8=; b=jUf+
	PHhC61HkOauLm/IHn1MrMfklj66WPTUyVwKVrrnjGYbyLsOJUa3I1oBGYIO3tnES
	4falPcmwRgXzCZMs1KR37H3WPJ4WgyNa69LXtbChVUy50FqTGyzlUUfATRHz3ozd
	kStvB0TP8Zw21ASY7GItvLH4FEXEZdAWKTTZGbUWzX5nqrUov52ZKcOeGN1Fcgty
	b3e/XsQn0hjPymzgaHUQkPRjDsYcxzrTGAV+9VcPM4kRz771sEIxyl2LZNO9cdvr
	0D4tlQv7hdvK4eDeCwsXE55DwATxmME3K/neD1Dj12wl8G1RXKvdv6SvkIfx7Urr
	GOu9hyKqReB2egUcNA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 476ps7r7n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 21:06:41 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH007.crowdstrike.sys (10.100.11.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Jun 2025 21:06:36 +0000
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
Subject: Re: [PATCH bpf-next v2 1/2] bpftool: Use appropriate permissions for map access
Date: Thu, 12 Jun 2025 07:06:33 +1000
Message-ID: <20250611210633.92084-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <c3b403f5-4849-44f3-82cb-b0b506b10138@kernel.org>
References: <c3b403f5-4849-44f3-82cb-b0b506b10138@kernel.org>
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
X-Proofpoint-ORIG-GUID: ApAh2UNTX3bCMpO1EKz6kR3-5nHK5-ov
X-Proofpoint-GUID: ApAh2UNTX3bCMpO1EKz6kR3-5nHK5-ov
X-Authority-Analysis: v=2.4 cv=OeyYDgTY c=1 sm=1 tr=0 ts=6849efe1 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=6IFa9wvqVegA:10 a=pl6vuDidAAAA:8 a=j6b8ci30a58VJQJFYksA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE3OCBTYWx0ZWRfX1mcB1tCRvOqP
 2JrS/+x3UxZWySTQe5gosarprNVi12I2fnWaZ2dL7d6+RphZkr4hlcgEcesYwLDiIZTDKBf/iKy
 gx/nPYISkHZ8EQh7ACp6KtnkVL8q40wRqx7gK/VBa0Jw3RGe5wJ4AmFNnbQABEypkC/6um/6hwU
 Wk9BPQVTe6c1oL/AwR5m/ZykB3rBzEVwmJO9MNfeQAXVs4OlVVJX31pYDfuhx+ic925lwuBVmB4
 7xdTow7zBVmgicFLZZDg5tGRTk5TKzBvxk9K0xjmarPe93yqSKAOnKqWr15cmfLeQZBcd92xTBE
 VEd5/cuKA3PK63cN+dJ7zYlu6TBBhlXeQmFCQ7P+9DRxXhkHIkJ2ny+NlqXRY1IwMMEld2yohng
 zjReRLJ1P8MFpiMsBPBlgmU3AMAKnf5LRZ2AGTj7BIAHe5EZ3Zi0fosabjwrdQL1PiPVLI4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110178

> > Modify several functions in tools/bpf/bpftool/common.c to allow
> > specification of requested access for file descriptors, such as
> > read-only access.
> >
> > Update bpftool to request only read access for maps when write
> > access is not required. This fixes errors when reading from maps
> > that are protected from modification via security_bpf_map.
> >
> > Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
>
>
> Thanks for this!
>
> I think the topic of map access in bpftool has been discussed in the
> path, but I can't remember what we said or find it again - maybe I don't
> remember correctly. Looks good to me overall.
>
> One question: How thoroughly have you tested that write permissions are
> necessary for the different cases? I'm asking because I'm wondering
> whether we could restrict to read-only in a couple more cases, see
> below. (At the end of the day it doesn't matter too much, it's fine
> being conservative and conserving write permissions for now, we can
> always refine later; it's already an improvement to do read-only for the
> dump/list cases).


The goal of this patch was to fix bpftool errors we experienced on our systems.
The efforts were focused only on changes to the affected subset of map commands.


> > +		/* Get an fd with the requested options. */
> > +		close(fd);
> > +		fd = bpf_map_get_fd_by_id_opts(id, opts);
> > +		if (fd < 0) {
> > +			p_err("can't get map by id (%u): %s", id,
> > +			      strerror(errno));
> > +			goto err_close_fds;
> > +		}
>
>
> We could maybe skip this step if the requested options are read-only, no
> need to close and re-open a fd in that case?


I agree. The change will be submitted with version 3.


> > -int map_parse_fds(int *argc, char ***argv, int **fds)
> > +int map_parse_fds(int *argc, char ***argv, int **fds, __u32 open_flags)
> >  {
> > +	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts);
> > +
> > +	if (open_flags & ~BPF_F_RDONLY) {
> > +		p_err("invalid open_flags: %x", open_flags);
> > +		return -1;
> > +	}
>
>
> I don't think we need this check, the flag is never passed by users. If
> you want to catch a bug, use an assert() instead?


I agree. This check is replaced with an assert and will be submitted with v3.


> > diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
> > index 5c39c2ed36a2..ad318a8667a4 100644
> > --- a/tools/bpf/bpftool/iter.c
> > +++ b/tools/bpf/bpftool/iter.c
> > @@ -37,7 +37,7 @@ static int do_pin(int argc, char **argv)
> >  				return -1;
> >  			}
> >  
> > -			map_fd = map_parse_fd(&argc, &argv);
> > +			map_fd = map_parse_fd(&argc, &argv, 0);
>
>
> Do you need write permissions here? (I don't remember.)


Iterator requires only read access. I changed it to BPF_F_RDONLY for v3.
An iterator test is added to v3.


> > -	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
> > +	fd = map_parse_fd_and_info(&argc, &argv, &info, &len, BPF_F_RDONLY);
>
>
> This one is surprising, don't you need write permissions to delete an
> element from the map? Please double-check if you haven't already, I
> wouldn't want to break "bpftool map delete".
>
> I note you don't test items deletion in your tests, by the way.


Right, the delete command requires write access. I changed it and added
an item deletion test to v3.


> >  static int do_pin(int argc, char **argv)
> >  {
> >  	int err;
> >  
> > -	err = do_pin_any(argc, argv, map_parse_fd);
> > +	err = do_pin_any(argc, argv, map_parse_read_only_fd);
> >  	if (!err && json_output)
> >  		jsonw_null(json_wtr);
> >  	return err;
> > @@ -1319,7 +1329,7 @@ static int do_create(int argc, char **argv)
> >  			if (!REQ_ARGS(2))
> >  				usage();
> >  			inner_map_fd = map_parse_fd_and_info(&argc, &argv,
> > -							     &info, &len);
> > +							     &info, &len, 0);
>
>
> Do you need write permissions for the inner map's fd? This is something
> that could be worth checking in the tests, as well.

The inner map fd can be created with read only access. I changed it and added
a test for map-of-maps creation to v3.


> > @@ -128,7 +128,8 @@ int do_event_pipe(int argc, char **argv)
> >  	int err, map_fd;
> >  
> >  	map_info_len = sizeof(map_info);
> > -	map_fd = map_parse_fd_and_info(&argc, &argv, &map_info, &map_info_len);
> > +	map_fd = map_parse_fd_and_info(&argc, &argv, &map_info, &map_info_len,
> > +				       0);
>
>
> This one might be worth checking, too.


An event pipe map fd requires write access as the map is updated by bpf_map_update_elem
inside __perf_buffer__new .



