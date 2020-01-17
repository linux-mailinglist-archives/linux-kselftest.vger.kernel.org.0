Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAA3F141245
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 21:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgAQUZf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 15:25:35 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24958 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727519AbgAQUZe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 15:25:34 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HKLp4Q024242;
        Fri, 17 Jan 2020 12:25:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=evXpv2lL/E95C3R+bQpiy3xWqiWPsb6rD4uK1d3RXD4=;
 b=gmNU3AXADiFZQ4BJZXmW9bOslbeW5TowQZzMs39v5xAK0M6oNqXC6ODnK3LeS3P2M3VT
 /Lf1TOLODRdmmIHxqwdaGtrCwOUXhG/jlR8BDSenYSri7DG/rBbCoTZxON/8oh3ubM5X
 9lgoyZKx6YT5J2Md2rnNIDHqQwAepCbREHw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xk0rb4jpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jan 2020 12:25:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jan 2020 12:24:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdjZy8cDQr/MnbSV95mfZrVmqpSZ3nigmbndNkIwxTJUt+/MRwjRePPjPXUbOaK3jVhQEEEZvku+gEiCXlNvwuh1jTeBAePHzqUpaRhqXiY66Fosil/olpQ7+5PCR562iEs48J7rpoy8g0NBFHS5OONTbheymP+6PO423pDUL3Nr506aJGzAJbSSRtOOKGA9JOQgl5r5KkOqeYNsDBxWH7pc/c32Mq3gWntCToyRAqvgjBkOZRX2WG9VWNDsaE/5Slnxd2FjP3syRgqq8KHKvMC3y4M6oHureHmij2mhvyPLZqFsXmXiXcj6OeP3+3FFmLbod5Bux/iCOqNpevpdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evXpv2lL/E95C3R+bQpiy3xWqiWPsb6rD4uK1d3RXD4=;
 b=K34C2KdOgvcjivj0uQWeaf4zv/4FzY93N9hKrWbEUX/2GBKeaQcdrXrgIqn1xRHO/C2qXxzeRXj9ZTUnfiDPCl43aa++AQ4CDCF4cFGyJQTmwp1xOpfbjAOliYkgHHpcFKzsEfcWmpGNS17Bw3LDIngm3NcByjhCPP5JlY7mL0g5pPj5HW+PrYO6C0l13pbEPhgCowgwejm/3K7t7+uKLZJXOaARzpSmHSm7SV9bqK/d0MQdpMYJubfQ+SRVXo7BZ/6XJjxTFTuj2lNiM8jUxOycm7sP9L4/HYVpXhlk6PUzlIwm0iSChLkus4E74J+tyk/yzcOmDkmfhGg7syXzHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evXpv2lL/E95C3R+bQpiy3xWqiWPsb6rD4uK1d3RXD4=;
 b=EjvgeX+ahoYXrbUIjpglXVRqayvLcBiQHuPciLTOYl56QuiddKepEEaUge+xSh+s+86r6nI7UQnLLgzTNzrFCk8jCYHB3jF5uCMqX89wuZa84Ftfvno9wcTaWju9UCoi41X6F+alOyw/kmC7MsR1L21kQq75MOcOJB3cTdR2ueE=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2424.namprd15.prod.outlook.com (52.135.194.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Fri, 17 Jan 2020 20:24:52 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2623.018; Fri, 17 Jan 2020
 20:24:52 +0000
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::1:301b) by CO1PR15CA0111.namprd15.prod.outlook.com (2603:10b6:101:21::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Fri, 17 Jan 2020 20:24:51 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] selftests/cgroup: add tests for cloning into
 cgroups
Thread-Topic: [PATCH v4 6/6] selftests/cgroup: add tests for cloning into
 cgroups
Thread-Index: AQHVzWG7CjxQRFj5V0+eAkwJ57hYU6fvTYeA
Date:   Fri, 17 Jan 2020 20:24:51 +0000
Message-ID: <20200117202441.GA11957@tower.DHCP.thefacebook.com>
References: <20200117181219.14542-1-christian.brauner@ubuntu.com>
 <20200117181219.14542-7-christian.brauner@ubuntu.com>
In-Reply-To: <20200117181219.14542-7-christian.brauner@ubuntu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0111.namprd15.prod.outlook.com
 (2603:10b6:101:21::31) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:301b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a798e5e-95a7-41d7-0ff5-08d79b8b4e90
x-ms-traffictypediagnostic: BYAPR15MB2424:
x-microsoft-antispam-prvs: <BYAPR15MB24242B61E1D181BDB82330F0BE310@BYAPR15MB2424.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(186003)(66556008)(66946007)(2906002)(4326008)(16526019)(66476007)(1076003)(8936002)(316002)(33656002)(9686003)(966005)(478600001)(8676002)(6506007)(5660300002)(55016002)(54906003)(81166006)(81156014)(6916009)(7696005)(86362001)(71200400001)(66446008)(64756008)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2424;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V69ula/9PACr9VcrvU2guMMhOOUS3jCF+UosZ7A7k64ukr4c2q5S2F8Jw2laeFfGeuDCWEes35Jyt7WKhvfoKEgMxhAu5gi1F+CmHOLjKmh6FqnSURke/DFVf3xqQluiP9+FT7byhArB31aRB02ftoL61D9vgKiQjUPV4VVpoa5MA4z06aEX9hAztObMXiEd/Gg/Nz5REjodKoDbd1a8btPP4Mrl5YO5Zf/s+LYHitqNcpg7LdUdEtY2rVfsN1xi4yNxlbBT4YcYFwvxBNvp8uNoXFuuz17VaFGelGTKQEgXs1cDTSpuM9C4eyMh9WtxaSa+CBnKn0oCTziN9/hE11PJTynwuMCY73oNpqvfJ2jMeW0R7501eoSF7lo79YotRLdyastMvzUB89OqA3jTq2aIeMJR7A+eiLobRepvmDkHHHg25tZpJIoIuQcDS3J9JqsiWZ/EGoLLSEy7dqjBCbAuaA76WlmomfXVpWpDDNsUjHyY49Kn1HkkctzITvw2fZ5+Wf9raUZg4ZJmUVM+uQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CDBAEED9F1D8AD419C94BDB35A4AFFFF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a798e5e-95a7-41d7-0ff5-08d79b8b4e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 20:24:51.8497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AMMD5aea3Tc6CouXcL3Ay1KyrtKMHaGN94DYPqkkmQxF4yFGW4N4DZ8EPFOCePEs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2424
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001170155
X-FB-Internal: deliver
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 17, 2020 at 07:12:19PM +0100, Christian Brauner wrote:
> Expand the cgroup test-suite to include tests for CLONE_INTO_CGROUP.
> This adds the following tests:
> - CLONE_INTO_CGROUP manages to clone a process directly into a correctly
>   delegated cgroup
> - CLONE_INTO_CGROUP fails to clone a process into a cgroup that has been
>   removed after we've opened an fd to it
> - CLONE_INTO_CGROUP fails to clone a process into an invalid domain
>   cgroup
> - CLONE_INTO_CGROUP adheres to the no internal process constraint
> - CLONE_INTO_CGROUP works with the freezer feature
>=20
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: cgroups@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thank you for adding tests!


> ---
> /* v1 */
> Link: https://lore.kernel.org/r/20191218173516.7875-4-christian.brauner@u=
buntu.com
>=20
> /* v2 */
> Link: https://lore.kernel.org/r/20191223061504.28716-4-christian.brauner@=
ubuntu.com
> unchanged
>=20
> /* v3 */
> Link: https://lore.kernel.org/r/20200117002143.15559-6-christian.brauner@=
ubuntu.com
> unchanged
>=20
> /* v3 */

v4?

> unchanged
> ---
>  tools/testing/selftests/cgroup/Makefile       |   6 +-
>  tools/testing/selftests/cgroup/cgroup_util.c  | 126 ++++++++++++++++++
>  tools/testing/selftests/cgroup/cgroup_util.h  |   4 +
>  tools/testing/selftests/cgroup/test_core.c    |  64 +++++++++
>  .../selftests/clone3/clone3_selftests.h       |  19 ++-
>  5 files changed, 214 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/self=
tests/cgroup/Makefile
> index 66aafe1f5746..967f268fde74 100644
> --- a/tools/testing/selftests/cgroup/Makefile
> +++ b/tools/testing/selftests/cgroup/Makefile
> @@ -11,6 +11,6 @@ TEST_GEN_PROGS +=3D test_freezer
> =20
>  include ../lib.mk
> =20
> -$(OUTPUT)/test_memcontrol: cgroup_util.c
> -$(OUTPUT)/test_core: cgroup_util.c
> -$(OUTPUT)/test_freezer: cgroup_util.c
> +$(OUTPUT)/test_memcontrol: cgroup_util.c ../clone3/clone3_selftests.h
> +$(OUTPUT)/test_core: cgroup_util.c ../clone3/clone3_selftests.h
> +$(OUTPUT)/test_freezer: cgroup_util.c ../clone3/clone3_selftests.h
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing=
/selftests/cgroup/cgroup_util.c
> index 8f7131dcf1ff..8a637ca7d73a 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -15,6 +15,7 @@
>  #include <unistd.h>
> =20
>  #include "cgroup_util.h"
> +#include "../clone3/clone3_selftests.h"
> =20
>  static ssize_t read_text(const char *path, char *buf, size_t max_len)
>  {
> @@ -331,12 +332,112 @@ int cg_run(const char *cgroup,
>  	}
>  }
> =20
> +pid_t clone_into_cgroup(int cgroup_fd)
> +{
> +#ifdef CLONE_ARGS_SIZE_VER2
> +	pid_t pid;
> +
> +	struct clone_args args =3D {
> +		.flags =3D CLONE_INTO_CGROUP,
> +		.exit_signal =3D SIGCHLD,
> +		.cgroup =3D cgroup_fd,
> +	};
> +
> +	pid =3D sys_clone3(&args, sizeof(struct clone_args));
> +	/*
> +	 * Verify that this is a genuine test failure:
> +	 * ENOSYS -> clone3() not available
> +	 * E2BIG  -> CLONE_INTO_CGROUP not available
> +	 */
> +	if (pid < 0 && (errno =3D=3D ENOSYS || errno =3D=3D E2BIG))
> +		goto pretend_enosys;
> +
> +	return pid;
> +
> +pretend_enosys:
> +#endif
> +	errno =3D ENOSYS;
> +	return -ENOSYS;
> +}
> +
> +int clone_reap(pid_t pid, int options)
> +{
> +	int ret;
> +	siginfo_t info =3D {
> +		.si_signo =3D 0,
> +	};
> +
> +again:
> +	ret =3D waitid(P_PID, pid, &info, options | __WALL | __WNOTHREAD);
> +	if (ret < 0) {
> +		if (errno =3D=3D EINTR)
> +			goto again;
> +		return -1;
> +	}
> +
> +	if (options & WEXITED) {
> +		if (WIFEXITED(info.si_status))
> +			return WEXITSTATUS(info.si_status);
> +	}
> +
> +	if (options & WSTOPPED) {
> +		if (WIFSTOPPED(info.si_status))
> +			return WSTOPSIG(info.si_status);
> +	}
> +
> +	if (options & WCONTINUED) {
> +		if (WIFCONTINUED(info.si_status))
> +			return 0;
> +	}
> +
> +	return -1;
> +}
> +
> +int dirfd_open_opath(const char *dir)
> +{
> +	return open(dir, O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW | O_PATH);
> +}
> +
> +#define close_prot_errno(fd)                                            =
       \
> +	if (fd >=3D 0) {                                                       =
  \
> +		int _e_ =3D errno;                                               \
> +		close(fd);                                                     \
> +		errno =3D _e_;                                                   \
> +	}
> +
> +static int clone_into_cgroup_run_nowait(const char *cgroup,
> +					int (*fn)(const char *cgroup, void *arg),
> +					void *arg)
> +{
> +	int cgroup_fd;
> +	pid_t pid;
> +
> +	cgroup_fd =3D  dirfd_open_opath(cgroup);
> +	if (cgroup_fd < 0)
> +		return -1;
> +
> +	pid =3D clone_into_cgroup(cgroup_fd);
> +	close_prot_errno(cgroup_fd);
> +	if (pid =3D=3D 0)
> +		exit(fn(cgroup, arg));
> +
> +	return pid;
> +}
> +
>  int cg_run_nowait(const char *cgroup,
>  		  int (*fn)(const char *cgroup, void *arg),
>  		  void *arg)
>  {
>  	int pid;
> =20
> +	pid =3D clone_into_cgroup_run_nowait(cgroup, fn, arg);
> +	if (pid > 0)
> +		return pid;
> +
> +	/* Genuine test failure. */
> +	if (pid < 0 && errno !=3D ENOSYS)
> +		return -1;
> +
>  	pid =3D fork();
>  	if (pid =3D=3D 0) {
>  		char buf[64];
> @@ -450,3 +551,28 @@ int proc_read_strstr(int pid, bool thread, const cha=
r *item, const char *needle)
> =20
>  	return strstr(buf, needle) ? 0 : -1;
>  }
> +
> +int clone_into_cgroup_run_wait(const char *cgroup)
> +{
> +	int cgroup_fd;
> +	pid_t pid;
> +
> +	cgroup_fd =3D  dirfd_open_opath(cgroup);
> +	if (cgroup_fd < 0)
> +		return -1;
> +
> +	pid =3D clone_into_cgroup(cgroup_fd);
> +	close_prot_errno(cgroup_fd);
> +	if (pid < 0)
> +		return -1;
> +
> +	if (pid =3D=3D 0)
> +		exit(EXIT_SUCCESS);
> +
> +	/*
> +	 * We don't care whether this fails. We only care whether the initial
> +	 * clone succeeded.
> +	 */
> +	(void)clone_reap(pid, WEXITED);
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing=
/selftests/cgroup/cgroup_util.h
> index 49c54fbdb229..5a1305dd1f0b 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.h
> +++ b/tools/testing/selftests/cgroup/cgroup_util.h
> @@ -50,3 +50,7 @@ extern int cg_wait_for_proc_count(const char *cgroup, i=
nt count);
>  extern int cg_killall(const char *cgroup);
>  extern ssize_t proc_read_text(int pid, bool thread, const char *item, ch=
ar *buf, size_t size);
>  extern int proc_read_strstr(int pid, bool thread, const char *item, cons=
t char *needle);
> +extern pid_t clone_into_cgroup(int cgroup_fd);
> +extern int clone_reap(pid_t pid, int options);
> +extern int clone_into_cgroup_run_wait(const char *cgroup);
> +extern int dirfd_open_opath(const char *dir);
> diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/s=
elftests/cgroup/test_core.c
> index c5ca669feb2b..96e016ccafe0 100644
> --- a/tools/testing/selftests/cgroup/test_core.c
> +++ b/tools/testing/selftests/cgroup/test_core.c
> @@ -25,8 +25,11 @@
>  static int test_cgcore_populated(const char *root)
>  {
>  	int ret =3D KSFT_FAIL;
> +	int err;
>  	char *cg_test_a =3D NULL, *cg_test_b =3D NULL;
>  	char *cg_test_c =3D NULL, *cg_test_d =3D NULL;
> +	int cgroup_fd =3D -EBADF;
> +	pid_t pid;
> =20
>  	cg_test_a =3D cg_name(root, "cg_test_a");
>  	cg_test_b =3D cg_name(root, "cg_test_a/cg_test_b");
> @@ -78,6 +81,52 @@ static int test_cgcore_populated(const char *root)
>  	if (cg_read_strcmp(cg_test_d, "cgroup.events", "populated 0\n"))
>  		goto cleanup;
> =20
> +	/* Test that we can directly clone into a new cgroup. */
> +	cgroup_fd =3D dirfd_open_opath(cg_test_d);
> +	if (cgroup_fd < 0)
> +		goto cleanup;
> +
> +	pid =3D clone_into_cgroup(cgroup_fd);
> +	if (pid < 0) {
> +		if (errno =3D=3D ENOSYS)
> +			goto cleanup_pass;
> +		goto cleanup;
> +	}
> +
> +	if (pid =3D=3D 0) {
> +		if (raise(SIGSTOP))
> +			exit(EXIT_FAILURE);
> +		exit(EXIT_SUCCESS);
> +	}
> +
> +	err =3D cg_read_strcmp(cg_test_d, "cgroup.events", "populated 1\n");
> +
> +	(void)clone_reap(pid, WSTOPPED);
> +	(void)kill(pid, SIGCONT);
> +	(void)clone_reap(pid, WEXITED);
> +
> +	if (err)
> +		goto cleanup;
> +
> +	if (cg_read_strcmp(cg_test_d, "cgroup.events", "populated 0\n"))
> +		goto cleanup;
> +
> +	/* Remove cgroup. */
> +	if (cg_test_d) {
> +		cg_destroy(cg_test_d);
> +		free(cg_test_d);
> +		cg_test_d =3D NULL;
> +	}
> +
> +	pid =3D clone_into_cgroup(cgroup_fd);
> +	if (pid < 0)
> +		goto cleanup_pass;
> +	if (pid =3D=3D 0)
> +		exit(EXIT_SUCCESS);
> +	(void)clone_reap(pid, WEXITED);
> +	goto cleanup;
> +
> +cleanup_pass:
>  	ret =3D KSFT_PASS;
> =20
>  cleanup:
> @@ -93,6 +142,8 @@ static int test_cgcore_populated(const char *root)
>  	free(cg_test_c);
>  	free(cg_test_b);
>  	free(cg_test_a);
> +	if (cgroup_fd >=3D 0)
> +		close(cgroup_fd);
>  	return ret;
>  }
> =20
> @@ -136,6 +187,16 @@ static int test_cgcore_invalid_domain(const char *ro=
ot)
>  	if (errno !=3D EOPNOTSUPP)
>  		goto cleanup;
> =20
> +	if (!clone_into_cgroup_run_wait(child))
> +		goto cleanup;
> +
> +	if (errno =3D=3D ENOSYS)
> +		goto cleanup_pass;
> +
> +	if (errno !=3D EOPNOTSUPP)
> +		goto cleanup;
> +
> +cleanup_pass:
>  	ret =3D KSFT_PASS;
> =20
>  cleanup:
> @@ -345,6 +406,9 @@ static int test_cgcore_internal_process_constraint(co=
nst char *root)
>  	if (!cg_enter_current(parent))
>  		goto cleanup;
> =20
> +	if (!clone_into_cgroup_run_wait(parent))
> +		goto cleanup;
> +
>  	ret =3D KSFT_PASS;
> =20
>  cleanup:
> diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/te=
sting/selftests/clone3/clone3_selftests.h
> index a3f2c8ad8bcc..91c1a78ddb39 100644
> --- a/tools/testing/selftests/clone3/clone3_selftests.h
> +++ b/tools/testing/selftests/clone3/clone3_selftests.h
> @@ -5,12 +5,24 @@
> =20
>  #define _GNU_SOURCE
>  #include <sched.h>
> +#include <linux/sched.h>
> +#include <linux/types.h>
>  #include <stdint.h>
>  #include <syscall.h>
> -#include <linux/types.h>
> +#include <sys/wait.h>
> +
> +#include "../kselftest.h"
> =20
>  #define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
> =20
> +#ifndef CLONE_INTO_CGROUP
> +#define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup=
 given the right permissions. */
> +#endif
> +
> +#ifndef CLONE_ARGS_SIZE_VER0
> +#define CLONE_ARGS_SIZE_VER0 64
> +#endif
> +
>  #ifndef __NR_clone3
>  #define __NR_clone3 -1
>  struct clone_args {
> @@ -22,10 +34,13 @@ struct clone_args {
>  	__aligned_u64 stack;
>  	__aligned_u64 stack_size;
>  	__aligned_u64 tls;
> +#define CLONE_ARGS_SIZE_VER1 80
>  	__aligned_u64 set_tid;
>  	__aligned_u64 set_tid_size;
> +#define CLONE_ARGS_SIZE_VER2 88
> +	__aligned_u64 cgroup;
>  };
> -#endif
> +#endif /* __NR_clone3 */
> =20
>  static pid_t sys_clone3(struct clone_args *args, size_t size)
>  {
> --=20
> 2.25.0
>=20
