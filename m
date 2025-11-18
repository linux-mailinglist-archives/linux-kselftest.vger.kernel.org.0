Return-Path: <linux-kselftest+bounces-45847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD92C68A46
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 10:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC9EF346608
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 09:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AF73161B2;
	Tue, 18 Nov 2025 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dn5nPlgd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E621A9F82;
	Tue, 18 Nov 2025 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459289; cv=none; b=S09YEDyini1vtWLtrgddFnexcUS7loLy/IzEz19FVmX8SORLqwYO6IS89vsAuC6H5TmdQIZeA4Izah+7jMIq9YT7jKk/b4MoHucCY2o9+Cm9cSPrFY9r8mGzvUowlyX0rR6wLgZCY4S76PgXRF0GkDgLrtL700b9ppqf9fqeEJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459289; c=relaxed/simple;
	bh=Xf6zS75W+Xui/UTgREpxQFXtMLhIQdKtQosLwHmVb7o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AVsaIPWmZ6ykplIxhLWw6iY0ggblwlDWeY46fr4hl3FsGvbDEGwjy60sat0b3jjazFfEjLnDLlLZpCVWzgUtSXQN1Q0VWSQLPBxh9YLiEDAAbnLL6BBVRpNS1gZ7xIwNJqDjZAeuTxXnoitfCYh5pqdTquAGAcaijQ7tadggfqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dn5nPlgd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI6U9eH006798;
	Tue, 18 Nov 2025 09:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=97DCAF
	CSQ1XM+EF/mPqIa768fNtqRdF1r0y2YGqmM1Y=; b=Dn5nPlgdOn3yLyjQHU/e2g
	7N6iWk4PK8m37iQtqU5rTgyb44Rq1rRaqMWDG7mAurui5LmSwV3zkSGSxvkK9i/d
	KHEoBZ94nCrsKD18n85EUP9jcnAmE3220SiLdcxSg5HCpBYvaJ99IZAiUe6lTkZI
	Vb5RNLGynkpLd4GL2mPzIgGaM4YAekk3Who+Eu4/1JU3A7XnFH4RLi/qBhZ7JP0b
	Y5EqRAc7L8u3LS3xqoggaJk95kSXjInAN3giLrcUvgALHvM/cAMKo8KRK0GlwfbA
	HISQpvruxX2VlnJgeOMwDUhDrDPSIzI3ShrDYIaVyq2gNJYSLMueavA1bmlGymQQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk9t11b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 09:47:24 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AI9bJ5N030415;
	Tue, 18 Nov 2025 09:47:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk9t117-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 09:47:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI7NnnW010448;
	Tue, 18 Nov 2025 09:47:22 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af3us2jat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 09:47:22 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AI9lKJN8585846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 09:47:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3335058052;
	Tue, 18 Nov 2025 09:47:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFAB85805A;
	Tue, 18 Nov 2025 09:47:14 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.98.109.80])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 18 Nov 2025 09:47:14 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Fix htab_update/reenter_update
 selftest failure
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20251117060752.129648-1-skb99@linux.ibm.com>
Date: Tue, 18 Nov 2025 15:17:01 +0530
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>, sachinpb@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A43B87B-A478-4AA1-8154-D459D25B3320@linux.ibm.com>
References: <20251117060752.129648-1-skb99@linux.ibm.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KMM4gIWZK2X-z6EtX4YMI80LvX1VKp7o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXzutXR4bg0xFI
 koA/V0INLXSqqEicJtw/JFEbKoIZ8e/7D2qWOyaYzlbLK7KIZyTf8gJjaAhE5G0aq+K0Pi17zjt
 Y2Sekf0iX9ABzNB9nB1Ka7OqLtlskiOmUQP1iwrgnDXH8uwv6g8ZMjy0/OZq5cXkNjo8USnp8bt
 NrmtMgbQXD4NUBomQbcr5INL9iab6tW09SEwUpOivh+mwrzoqakdfv6MsSJ+JfH+EMf93xPpDBW
 m60+0CSF42t5uS+3I3wpFo1moY6mPJts73eBu3cB0S9oxlnSwS6brc2i1OBULMQ42ucH9hqO1Z1
 CtMZUL6G7fB1/sC7TtlsUue4kRY9n+u1ayzSpmud7O0fr96vuRvgucxHju4IykDAbaY5Zke/4o9
 NHU0buBefripP2hoN1KZHLMGB3AEtg==
X-Proofpoint-ORIG-GUID: JaQ19AOOl--rxcJTnj4pCPfWUknE21uZ
X-Authority-Analysis: v=2.4 cv=XtL3+FF9 c=1 sm=1 tr=0 ts=691c40ac cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=LI0gvHg8sEG1FREOOLkA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032



> On 17 Nov 2025, at 11:37=E2=80=AFAM, Saket Kumar Bhaskar =
<skb99@linux.ibm.com> wrote:
>=20
> Since commit 31158ad02ddb ("rqspinlock: Add deadlock detection
> and recovery") the updated path on re-entrancy now reports deadlock
> via -EDEADLK instead of the previous -EBUSY.
>=20
> Also, the way reentrancy was exercised (via fentry/lookup_elem_raw)
> has been fragile because lookup_elem_raw may be inlined
> (find_kernel_btf_id() will return -ESRCH).
>=20
> To fix this fentry is attached to bpf_obj_free_fields() instead of
> lookup_elem_raw() and:
>=20
> - The htab map is made to use a BTF-described struct val with a
>  struct bpf_timer so that check_and_free_fields() reliably calls
>  bpf_obj_free_fields() on element replacement.
>=20
> - The selftest is updated to do two updates to the same key (insert +
>  replace) in prog_test.
>=20
> - The selftest is updated to align with expected errno with the
>  kernel=E2=80=99s current behavior.
>=20
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>

Tested this patch by applying on top of bpd-next and it works as =
expected. Please add below tag.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

With this change:

./test_progs -t htab_update
#144/1   htab_update/reenter_update:OK
#144/2   htab_update/concurrent_update:OK
#144     htab_update:OK
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Regards,
Venkat.

> ---
> Changes since v2:
> Addressed CI failures:
> * Initialize key to 0 before the first update.
> * Used pointer value to pass for update and memset rather than
>  &value.
>=20
> v2: =
https://lore.kernel.org/all/20251114152653.356782-1-skb99@linux.ibm.com/
>=20
> Changes since v1:
> Addressed comments from Alexei:
> * Fixed the scenario where test may fail when lookup_elem_raw()
>  is inlined.
>=20
> v1: =
https://lore.kernel.org/all/20251106052628.349117-1-skb99@linux.ibm.com/
>=20
> .../selftests/bpf/prog_tests/htab_update.c    | 37 ++++++++++++++-----
> .../testing/selftests/bpf/progs/htab_update.c | 19 +++++++---
> 2 files changed, 41 insertions(+), 15 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c =
b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> index 2bc85f4814f4..d0b405eb2966 100644
> --- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
> +++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> @@ -15,17 +15,17 @@ struct htab_update_ctx {
> static void test_reenter_update(void)
> {
> struct htab_update *skel;
> - unsigned int key, value;
> + void *value =3D NULL;
> + unsigned int key, value_size;
> int err;
>=20
> skel =3D htab_update__open();
> if (!ASSERT_OK_PTR(skel, "htab_update__open"))
> return;
>=20
> - /* lookup_elem_raw() may be inlined and find_kernel_btf_id() will =
return -ESRCH */
> - bpf_program__set_autoload(skel->progs.lookup_elem_raw, true);
> + bpf_program__set_autoload(skel->progs.bpf_obj_free_fields, true);
> err =3D htab_update__load(skel);
> - if (!ASSERT_TRUE(!err || err =3D=3D -ESRCH, "htab_update__load") || =
err)
> + if (!ASSERT_TRUE(!err, "htab_update__load") || err)
> goto out;
>=20
> skel->bss->pid =3D getpid();
> @@ -33,14 +33,33 @@ static void test_reenter_update(void)
> if (!ASSERT_OK(err, "htab_update__attach"))
> goto out;
>=20
> - /* Will trigger the reentrancy of bpf_map_update_elem() */
> + value_size =3D bpf_map__value_size(skel->maps.htab);
> +
> + value =3D calloc(1, value_size);
> + if (!ASSERT_OK_PTR(value, "calloc value"))
> + goto out;
> + /*
> + * First update: plain insert. This should NOT trigger the =
re-entrancy
> + * path, because there is no old element to free yet.
> + */
> key =3D 0;
> - value =3D 0;
> - err =3D bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, =
&value, 0);
> - if (!ASSERT_OK(err, "add element"))
> + err =3D bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, =
value, BPF_ANY);
> + if (!ASSERT_OK(err, "first update (insert)"))
> + goto out;
> +
> + /*
> + * Second update: replace existing element with same key and trigger
> + * the reentrancy of bpf_map_update_elem().
> + * check_and_free_fields() calls bpf_obj_free_fields() on the old
> + * value, which is where fentry program runs and performs a nested
> + * bpf_map_update_elem(), triggering -EDEADLK.
> + */
> + memset(value, 0, value_size);
> + err =3D bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, =
value, BPF_ANY);
> + if (!ASSERT_OK(err, "second update (replace)"))
> goto out;
>=20
> - ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy");
> + ASSERT_EQ(skel->bss->update_err, -EDEADLK, "no reentrancy");
> out:
> htab_update__destroy(skel);
> }
> diff --git a/tools/testing/selftests/bpf/progs/htab_update.c =
b/tools/testing/selftests/bpf/progs/htab_update.c
> index 7481bb30b29b..195d3b2fba00 100644
> --- a/tools/testing/selftests/bpf/progs/htab_update.c
> +++ b/tools/testing/selftests/bpf/progs/htab_update.c
> @@ -6,24 +6,31 @@
>=20
> char _license[] SEC("license") =3D "GPL";
>=20
> +/* Map value type: has BTF-managed field (bpf_timer) */
> +struct val {
> + struct bpf_timer t;
> + __u64 payload;
> +};
> +
> struct {
> __uint(type, BPF_MAP_TYPE_HASH);
> __uint(max_entries, 1);
> - __uint(key_size, sizeof(__u32));
> - __uint(value_size, sizeof(__u32));
> + __type(key, __u32);
> + __type(value, struct val);
> } htab SEC(".maps");
>=20
> int pid =3D 0;
> int update_err =3D 0;
>=20
> -SEC("?fentry/lookup_elem_raw")
> -int lookup_elem_raw(void *ctx)
> +SEC("?fentry/bpf_obj_free_fields")
> +int bpf_obj_free_fields(void *ctx)
> {
> - __u32 key =3D 0, value =3D 1;
> + __u32 key =3D 0;
> + struct val value =3D { .payload =3D 1 };
>=20
> if ((bpf_get_current_pid_tgid() >> 32) !=3D pid)
> return 0;
>=20
> - update_err =3D bpf_map_update_elem(&htab, &key, &value, 0);
> + update_err =3D bpf_map_update_elem(&htab, &key, &value, BPF_ANY);
> return 0;
> }
> --=20
> 2.51.0



