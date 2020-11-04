Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FF02A6424
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 13:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgKDMUx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Nov 2020 07:20:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729309AbgKDMUw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Nov 2020 07:20:52 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A4CCRvH046617;
        Wed, 4 Nov 2020 07:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=Io8LaAhONiSkQDZNtm2vbjjtJiR+o/nmjffSDuXNvOU=;
 b=UtDYr4tXu1zlzzT6yGwT706GjloxI2dLhCZkYjJVmkt73vTqRvXa9iz6Y86eI1P79ibv
 qfZoQ2cE72Few5Cs8R6yjHwemwP641kiOWbc4VGag70gGL1DN5WBr9s+iFHAHxBdZSe0
 w5hPhRBqF1jUo1K+VIrqHZx7Fb9T8toyp6BwDovR06nELCvEVeiasd7dYHioZHyIrVDa
 8ghuxZ1czfS8o1uQRC2VUC848ksPn5LQ6r/8DEbaPs1v6mFGfuRAfG8U2R4e/6vvY1ZI
 xLNE1twOmQx3He2clorPJQgIHUGJa/cZSmRQxHvqYIjPcI10CURXsMkSLmvBe/3XpE/E NQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34ksrucxtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 07:20:45 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A4CHiX3001812;
        Wed, 4 Nov 2020 12:20:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 34h01qt75x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 12:20:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A4CKgKK9110018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Nov 2020 12:20:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E85C9AE055;
        Wed,  4 Nov 2020 12:20:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9AC0AE045;
        Wed,  4 Nov 2020 12:20:40 +0000 (GMT)
Received: from [9.77.204.73] (unknown [9.77.204.73])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Nov 2020 12:20:40 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH] selftests/cgroup: Fix build on older distros
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <20201104100545.657898-1-mpe@ellerman.id.au>
Date:   Wed, 4 Nov 2020 17:50:40 +0530
Cc:     linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        christian@brauner.io
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC8A9B1A-B080-499D-B81C-31055E1C8BD8@linux.vnet.ibm.com>
References: <20201104100545.657898-1-mpe@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
X-Mailer: Apple Mail (2.3445.104.17)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_06:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=884 mlxscore=0
 bulkscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040086
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 04-Nov-2020, at 3:35 PM, Michael Ellerman <mpe@ellerman.id.au> =
wrote:
>=20
> On older distros struct clone_args does not have a cgroup member,
> leading to build errors:
>=20
>  cgroup_util.c: In function 'clone_into_cgroup':
>  cgroup_util.c:343:4: error: 'struct clone_args' has no member named =
'cgroup'
>=20
> But the selftests already have a locally defined version of the
> structure which is up to date, called __clone_args.
>=20
> So use __clone_args which fixes the error.
>=20

Argument passed to sys_clone3() will also require a similar change.

-	pid =3D sys_clone3(&args, sizeof(struct clone_args));
+	pid =3D sys_clone3(&args, sizeof(struct __clone_args));

Without this compilation still fails(at least for me) due to following =
error

cgroup_util.c: In function 'clone_into_cgroup':
cgroup_util.c:346:33: error: invalid application of 'sizeof' to =
incomplete type 'struct clone_args'
  pid =3D sys_clone3(&args, sizeof(struct clone_args));

> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> tools/testing/selftests/cgroup/cgroup_util.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c =
b/tools/testing/selftests/cgroup/cgroup_util.c
> index 05853b0b8831..58e30f65df5e 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -337,7 +337,7 @@ pid_t clone_into_cgroup(int cgroup_fd)
> #ifdef CLONE_ARGS_SIZE_VER2
> 	pid_t pid;
>=20
> -	struct clone_args args =3D {
> +	struct __clone_args args =3D {
> 		.flags =3D CLONE_INTO_CGROUP,
> 		.exit_signal =3D SIGCHLD,
> 		.cgroup =3D cgroup_fd,
>=20
> base-commit: cf7cd542d1b538f6e9e83490bc090dd773f4266d
> --=20
> 2.25.1
>=20

