Return-Path: <linux-kselftest+bounces-10808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FE68D2933
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 02:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2887286453
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 00:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786BB17F5;
	Wed, 29 May 2024 00:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WM/ey2t+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9E79EF;
	Wed, 29 May 2024 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716940913; cv=none; b=f/cFFRFbmKqQAX+KGXa5nuAn0iu5J6D4896OctlFoDmaJoSSC9zJbp7pTzyPOdoiOdh4r23cykTGunz+iTXi9q2FY2DA1BlXM9u/waVx2Pnf7nDZav7bUby6dOp6Wpt5TLqaX8jj8I8WGmXIj0t44zLrWFGTMvKZIUsyfasCra8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716940913; c=relaxed/simple;
	bh=14q0h+M1hDimTb7LsxKgSkPBM/2pa7VZMhjId8JSELE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UNJK1Ip3nIgfqmLG7vqMjw5h5lddscOUlALTOA1hXelPfcNC3SpVfKZkefHcueGjbTAHvptxj2q4IIa00vVVYeVCEo/x2veiFyQh9HvVjYPBlIFwFaOh/fYMZMm2fnTHERi0KSoRSmnOCA1uraPXnRAq9m+p3eRD38TE2AWP+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WM/ey2t+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SNsLXH021618;
	Wed, 29 May 2024 00:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=14q0h+M1hDimTb7LsxKgSkPBM/2pa7VZMhjId8JSELE=;
 b=WM/ey2t+zyy7By4GHNlmXbE1NoSsUMeLAvZS7+ZTdir1clGKGXXOHRRJ7RsjK4fC0ICm
 B1KeZp9GuOFTaVaK8PA/Elh7+86igNY5ZaDj7HYNo70lmjxFfMBhy+Ybfc++WznjXsGH
 JhiiMb9uVpc9870UuP4E6oQOR00yBB31qQS8ZNKyWLt8HRaySojI6QuMdrUE/9nyzuiN
 fbnRe1jRcN+4W8qwjTuhP5CEUvEmSJPqt/JwAXkdvYOeNhMv7x36bGZ6KbPCNSu9yE8n
 76ObCG2a3/7LYCGqKQ9q/y8hxHxSaADz+nAXvfgxfijXX5wOgG/XDXmSM4VWO2giGlyz Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydsb2r0e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 00:01:12 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44T01BIG030542;
	Wed, 29 May 2024 00:01:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydsb2r0e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 00:01:11 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44SKRjHC028965;
	Wed, 29 May 2024 00:01:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ydpaygtxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 00:01:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44T0188350594052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 00:01:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1239D2004E;
	Wed, 29 May 2024 00:01:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DADAF20049;
	Wed, 29 May 2024 00:01:06 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 May 2024 00:01:06 +0000 (GMT)
Message-ID: <8c406b8d6cf2347589c1e40f0b87095550306c4a.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Enable INET_XFRM_TUNNEL in
 config
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Geliang Tang
 <geliang@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard
 Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John
 Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Date: Wed, 29 May 2024 02:01:06 +0200
In-Reply-To: <978a90ad-2e4c-ac06-30bf-6449444d47f9@iogearbox.net>
References: 
	<acb442e38544bc5c60dcaa61d56ca1e6bbbc82fe.1715823610.git.tanggeliang@kylinos.cn>
	 <978a90ad-2e4c-ac06-30bf-6449444d47f9@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0LW0Bxfb_jGbNeszuLcg70yFxWhdgQA9
X-Proofpoint-ORIG-GUID: 3uyfs8doU9VHDw4mlFebWa_RgW67nIMb
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280177

On Fri, 2024-05-24 at 18:27 +0200, Daniel Borkmann wrote:
> On 5/16/24 3:41 AM, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >=20
> > The kconfigs CONFIG_INET_XFRM_TUNNEL and CONFIG_INET6_XFRM_TUNNEL
> > are
> > needed by test_tunnel tests. This patch enables them together with
> > the
> > dependent kconfigs CONFIG_INET_IPCOMP and CONFIG_INET6_IPCOMP.
> >=20
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > =C2=A0 tools/testing/selftests/bpf/config | 4 ++++
> > =C2=A0 1 file changed, 4 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/bpf/config
> > b/tools/testing/selftests/bpf/config
> > index eeabd798bc3a..8aa56e6bdac1 100644
> > --- a/tools/testing/selftests/bpf/config
> > +++ b/tools/testing/selftests/bpf/config
> > @@ -95,3 +95,7 @@ CONFIG_XDP_SOCKETS=3Dy
> > =C2=A0 CONFIG_XFRM_INTERFACE=3Dy
> > =C2=A0 CONFIG_TCP_CONG_DCTCP=3Dy
> > =C2=A0 CONFIG_TCP_CONG_BBR=3Dy
> > +CONFIG_INET_IPCOMP=3Dy
> > +CONFIG_INET_XFRM_TUNNEL=3Dy
> > +CONFIG_INET6_IPCOMP=3Dy
> > +CONFIG_INET6_XFRM_TUNNEL=3Dy
> >=20
>=20
> [ +Ilya ]
>=20
> Looks like this triggers a boot hang on s390x :
>=20
> https://github.com/kernel-patches/bpf/actions/runs/9215175853/job/2535357=
4288

Hi,

I could not reproduce this neither with vmtest nor with my own build,
and it doesn't look related.

I'm not exactly sure what could cause d_alloc_parallel() to hang, but
apparently the CI is using a different vmtest script, which uses 9p to
mount root - perhaps there is a deadlock in 9p?

Can someone retrigger the build to see if the issue persists?

Best regards,
Ilya

