Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59D6282994
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Oct 2020 10:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgJDIRl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Oct 2020 04:17:41 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15428 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDIRl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Oct 2020 04:17:41 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7984ef0000>; Sun, 04 Oct 2020 01:16:47 -0700
Received: from [10.2.58.214] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 4 Oct
 2020 08:17:40 +0000
Subject: Re: [PATCH v2 8/8] selftests/vm: hmm-tests: remove the libhugetlbfs
 dependency
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-s390@vger.kernel.org>
References: <20200929212747.251804-1-jhubbard@nvidia.com>
 <20200929212747.251804-9-jhubbard@nvidia.com>
 <alpine.DEB.2.21.2010040948370.19434@felia>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <47ff8f88-3bb2-e649-a898-bb258ecac874@nvidia.com>
Date:   Sun, 4 Oct 2020 01:17:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2010040948370.19434@felia>
Content-Type: multipart/mixed;
        boundary="------------E9109043627EDAF5C3FD96C7"
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601799407; bh=6JT89rhByePIC47NFYMOG7QBUItmdghhPp5UY2x0RwA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         X-Originating-IP:X-ClientProxiedBy;
        b=J+0LpNmv4Sa+V0asxA8meMyFR/7B2yp/2kD2XhCc/rfsccuzxS34bOkY6XgNznFCq
         20HOaF06JDbnEpyy+T6Wxa96X7Ksqdsidpi3lpG6n0hcof87q7qAVwFLv/gPbZWuwC
         +1QkOjBl5H9Lx5huV8222KxxFxTp6UwvK4uA6QeH17yRaTb6tX2Cg1l1pAbxXw9dF+
         CksfBgE6FF0EEVBX6tcDTUzSqLd5aO8+IELoteWSoRKvvIUMXGJrcin/8fJWvPxP2P
         2Zg7JpfFvjde/eG9RLKq9tKwHF4nFaLDKxANyhUX3Zj7xenVeLMkswFh17magxdwUO
         4NHSTQhDgNm2w==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--------------E9109043627EDAF5C3FD96C7
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/20 12:55 AM, Lukas Bulwahn wrote:
> On Tue, 29 Sep 2020, John Hubbard wrote:
...
> John, your change makes:
> 
> tools/testing/selftests$ make clean
> 
> fail with:
> 
> make[1]: Entering directory
> '/home/lukas/repositories/kernel.org/pub/scm/linux/kernel/git/next/linux-next/tools/testing/selftests/vm'
> Makefile:4: local_config.mk: No such file or directory
> ./check_config.sh gcc
> make[1]: execvp: ./check_config.sh: Permission denied
> Makefile:141: recipe for target 'local_config.mk' failed
> make[1]: *** [local_config.mk] Error 127


Yes, there's a fix for that, here:

https://lore.kernel.org/r/20201003002142.32671-2-jhubbard@nvidia.com

...and Andrew Morton has merged it into his tree as of yesterday, too.
(As shown in the attached email, which has notes about how that flow
works.)


Sorry that you had to run into that, but this should fix you up.


thanks,
-- 
John Hubbard
NVIDIA

--------------E9109043627EDAF5C3FD96C7
Content-Type: message/rfc822;
	name="+ selftests-vm-hmm-tests-remove-the-libhugetlbfs-dependency-fix.patch
 added to -mm tree.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="+ selftests-vm-hmm-tests-remove-the-libhugetlbfs-dependency-";
	filename*1="fix.patch added to -mm tree.eml"

Received: from DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) by
 DM6PR12MB4140.namprd12.prod.outlook.com with HTTPS; Sat, 3 Oct 2020 01:01:05
 +0000
Received: from DM5PR2201CA0005.namprd22.prod.outlook.com (2603:10b6:4:14::15)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sat, 3 Oct
 2020 01:01:04 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::43) by DM5PR2201CA0005.outlook.office365.com
 (2603:10b6:4:14::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend
 Transport; Sat, 3 Oct 2020 01:01:04 +0000
Authentication-Results: spf=softfail (sender IP is 216.228.112.35)
 smtp.mailfrom=linux-foundation.org; NVIDIA.mail.onmicrosoft.com; dkim=pass
 (signature was verified) header.d=kernel.org;NVIDIA.mail.onmicrosoft.com;
 dmarc=none action=none header.from=linux-foundation.org;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 linux-foundation.org discourages use of 216.228.112.35 as permitted sender)
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3433.35 via Frontend Transport; Sat, 3 Oct 2020 01:01:04 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Oct
 2020 01:00:56 +0000
Received: from hqnvemgate25.nvidia.com (216.228.121.13) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 3 Oct 2020 01:00:56 +0000
Received: from hqemgatev14-mgt.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-GCM-SHA384)
	id <B5f77cd130005>; Fri, 02 Oct 2020 18:00:03 -0700
Authentication-Results-Original: hqemgatev14.nvidia.com; dkim=permerror
 (signing time is in the future) header.i=none; spf=None
 smtp.pra=akpm@linux-foundation.org; spf=Pass
 smtp.mailfrom=akpm@linux-foundation.org; spf=None
 smtp.helo=postmaster@mail.kernel.org
Received-SPF: None (NvidiaGateway08: no sender authenticity
  information available from domain of
  akpm@linux-foundation.org) identity=pra;
  client-ip=198.145.29.99; receiver=NvidiaGateway08;
  envelope-from="akpm@linux-foundation.org";
  x-sender="akpm@linux-foundation.org";
  x-conformance=sidf_compatible
Received-SPF: Pass (NvidiaGateway08: domain of
  akpm@linux-foundation.org designates 198.145.29.99 as
  permitted sender) identity=mailfrom; client-ip=198.145.29.99;
  receiver=NvidiaGateway08;
  envelope-from="akpm@linux-foundation.org";
  x-sender="akpm@linux-foundation.org";
  x-conformance=sidf_compatible; x-record-type="v=spf1"
Received-SPF: None (NvidiaGateway08: no sender authenticity
  information available from domain of
  postmaster@mail.kernel.org) identity=helo;
  client-ip=198.145.29.99; receiver=NvidiaGateway08;
  envelope-from="akpm@linux-foundation.org";
  x-sender="postmaster@mail.kernel.org";
  x-conformance=sidf_compatible
X-SLBL-Result: SAFE-LISTED
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="6966656"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
IronPort-PHdr: =?us-ascii?q?9a23=3Agv1d4BBiQ53a5XrwE2++UyQJP3V1i/DPJgcQr6Ef?=
 =?us-ascii?q?pfdOf6CkpsuwOUXe4bNugUXPUIGd7OhL2bKP7/LQHFcY6JPEi0gsNYRWXkVf28?=
 =?us-ascii?q?EXmREwRcCCFEv3JeLraCp8G95NBgc8riOLdHNNEcO7XGX853i77DocABL6b1An?=
 =?us-ascii?q?IuXzB56XgcOq0ey755zUZUNPnjXvOL4=3D?=
X-IPAS-Result: =?us-ascii?q?A0k+AADIzHdfmGMdkcZgFoVcVjIsiAaFOaRYCwEBAQEBAQE?=
 =?us-ascii?q?BAQknBgIEAQECgQOFfgIdBwEENBMCEAEBAQQBAQECAQMEAQEBAgEBEAEBAQEBC?=
 =?us-ascii?q?AsLBimFYwyDVIECAQEBAQEBAQEBAQEBAQEBAQEBAQEWAg1UJkIBRgEBLAwvAn4?=
 =?us-ascii?q?PEoMmAYJ8BQqoY4IogwEBAQV7OAERBRgmhB6BIgmBOIkfgUuCRxuCAIhjhjCQH?=
 =?us-ascii?q?Iw2mQWBBXaLb5FUMYMOigKUDYYMjQeBeYdQgSWQUIR+gWuBe31DgmkJCj0ZDY4?=
 =?us-ascii?q?5HYhOhWIhMwIBNAIGCgEBAwl8iwaCRgEB?=
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mail.kernel.org ([198.145.29.99])
  by hqemgatev14.nvidia.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 17:57:15 -0700
Received: from X1 (c-76-21-107-111.hsd1.ca.comcast.net [76.21.107.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id E9988206F8;
	Sat,  3 Oct 2020 01:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601686855;
	bh=x3gAE/nOYInd+iPttFaupiNFpGv9PNTRZ3qKZCTo0jk=;
	h=Date:From:To:Subject:From;
	b=cBFrILz7tEWvN2ZiHBnP7zuzaqqLrGBwE4x0yzQCtuyyNejmmmYoAPbW8BuXIocZQ
	 P9147XK11uKx3tgQ4VHZftNLuU2A8/ecr4+81O+RAW4HO9NO7R38PJAAxm7IWfWI3o
	 k5opps8z2LC6cFHstuJ2wfr8obP0dOzo2zx9YNDM=
Date: Fri, 2 Oct 2020 18:00:54 -0700
From: <akpm@linux-foundation.org>
To: <mm-commits@vger.kernel.org>, <jhubbard@nvidia.com>
Subject: +
 selftests-vm-hmm-tests-remove-the-libhugetlbfs-dependency-fix.patch added to
 -mm tree
Message-ID: <20201003010054.M-moQ%akpm@linux-foundation.org>
User-Agent: s-nail v14.9.10
Return-Path: akpm@linux-foundation.org
Content-Type: text/plain
X-OrganizationHeadersPreserved: HQMAIL111.nvidia.com
X-MS-Exchange-Organization-ExpirationStartTime: 03 Oct 2020 01:01:04.1683
 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: OriginalSubmit
X-MS-Exchange-Organization-ExpirationInterval: 1:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: OriginalSubmit
X-MS-Exchange-Organization-Network-Message-Id: 9343151c-d413-43c3-b6f0-08d86737cd82
X-EOPAttributedMessage: 0
X-MS-Exchange-Organization-MessageDirectionality: Originating
X-CrossPremisesHeadersPromoted: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-CrossPremisesHeadersFiltered: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Exchange-Organization-AuthSource: HQMAIL111.nvidia.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-OriginatorOrg: nvidia.com
X-MS-Office365-Filtering-Correlation-Id: 9343151c-d413-43c3-b6f0-08d86737cd82
X-MS-TrafficTypeDiagnostic: DM5PR12MB1146:
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-Organization-SCL: 1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(6266002)(8676002)(966005)(36906005)(6966003)(86362001)(5660300002)(36756003)(1096003)(336012)(8936002)(1076003)(83080400001)(26005)(2616005)(356005)(9686003)(7636003)(156005)(82310400003)(83380400001)(956004);DIR:INB;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2020 01:01:04.0503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9343151c-d413-43c3-b6f0-08d86737cd82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: HQMAIL111.nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1146
X-MS-Exchange-Transport-EndToEndLatency: 00:00:01.2741935
X-MS-Exchange-Processed-By-BccFoldering: 15.20.3412.034
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;auth:0;dest:I;ENG:(20160514016)(750128)(520011016)(944506458)(944626604);
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?O/hrVY6VPBb1w0iki/d3stIlTprNzy4OVrEnQucy5govHvMgSa73cGKSLo?=
 =?iso-8859-1?Q?jMA6M0QcZnpdNV+zbmuOo7i4TWe7IN8oMqI7Ao1HyCKZ4OZO2PbZgAQqc4?=
 =?iso-8859-1?Q?KbpGWxasAtkDzbfB3VtPVOJow/QNT7elzwcDsXkFmflZyGk+6wM05sV6/S?=
 =?iso-8859-1?Q?NctFQJnGYw1tl61zit2tgN2LsqQzIyjL6KuiHKik4I3x4pH1kBTMvzA/L3?=
 =?iso-8859-1?Q?Gof6taPTCVca8w2PM2OORQIsxg2g0qcZIXKlfgPafgudgFC6l6aGVBxzuN?=
 =?iso-8859-1?Q?/XcMFI/pUsTqwuxLBs9jp27OjIuzL8RP/RZZRxK3+DqSidaxCWf4A5d6WL?=
 =?iso-8859-1?Q?DZsljpuPBE5kRQIFgr3ehqSDQMBuZhMXpSyfhOMQbX/3lNCV+tpWWq/8RT?=
 =?iso-8859-1?Q?QS8fAH6dhLLTGH+P4nMAgQNHGBU8WWlrFiOQUUP56MClx9UfB1mU5lMDog?=
 =?iso-8859-1?Q?sOF8sNtGtC9Hy2x26DGhPO5WSwXsygWC5PRTssMU5Pn2iXpHIE0t7cGQb6?=
 =?iso-8859-1?Q?RpRz+bj/Aa3KtNNo4uXwRBF8cz6cOUmf+iOYtTnEkh0mKaUMcr52GVr9lI?=
 =?iso-8859-1?Q?xz3oUxyDPWdLlMmRgdziV9Z1BLgL6OTQjo7XSdkUJNxVEYVUW0+pcDCteK?=
 =?iso-8859-1?Q?2Hh4qyJO+8uVhj9k2uNy06Qf49EGlEJulXvrbL99K4JP4dmFHPwv6+tcSx?=
 =?iso-8859-1?Q?N1EICK8m2RbtTeITnuUxvlnNb+6nxFaGJxX+U/b4MmZlspGN0krCPjufEM?=
 =?iso-8859-1?Q?05GMG5VlmnBXJ3xUss9anfz8R6qIcLGXtup2hpUmYwFQGrJwP+h6qzl+Jy?=
 =?iso-8859-1?Q?9RAl2WqVvSKrOTR8TMsj2GuMpf4TM1+6WWsAzJC2VhsUyM2Jjaa9GT2UWa?=
 =?iso-8859-1?Q?LWgUbQhUCdh0MfqeylKlOC0t7pUc4QGp2hFxYjzBaW4sMm2k8/aQh2JPZi?=
 =?iso-8859-1?Q?7wuNSOXrLVQpgO1uN3xZp/lwqpjREwUT4Gs4/7IMNuQpr+91vDgqjC7ww6?=
 =?iso-8859-1?Q?y1ZVFgq68I3d/Ydtb2iOddBl9kDcEa2n3MjhGva7pTHGFwCrTkjKl73HYs?=
 =?iso-8859-1?Q?MjKKdh8IO2VAn0nw7UpCAuuUqG3Fc46TswMZeBQ3GZ0jT81pqF+pE9pRCF?=
 =?iso-8859-1?Q?974eRebE9iHllc48zMwwcCUN8+twP+kZVX5KmyxVHYYfY78FP8NB9ShPyo?=
 =?iso-8859-1?Q?5IMNFwtoPMswlFMeV/CTqYvn9uGBuQjWDXWxP+tT/2Tdb5XkZXIWiHnI?=
MIME-Version: 1.0


The patch titled
     Subject: selftests/vm: fix an improper dependency upon executable script permissions
has been added to the -mm tree.  Its filename is
     selftests-vm-hmm-tests-remove-the-libhugetlbfs-dependency-fix.patch

This patch should soon appear at
    https://ozlabs.org/~akpm/mmots/broken-out/selftests-vm-hmm-tests-remove-the-libhugetlbfs-dependency-fix.patch
and later at
    https://ozlabs.org/~akpm/mmotm/broken-out/selftests-vm-hmm-tests-remove-the-libhugetlbfs-dependency-fix.patch

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next and is updated
there every 3-4 working days

------------------------------------------------------
From: John Hubbard <jhubbard@nvidia.com>
Subject: selftests/vm: fix an improper dependency upon executable script permissions

commit 30fb9454ab23 ("selftests/vm: hmm-tests: remove the libhugetlbfs
dependency") created the new check_config.sh file without the execute bit
set.  This is a problem because that same commit caused the Makefile to
invoke it "./check_config.sh", so now "make" is failing in that directory.

Scripts are not supposed to depend on the executable bit being set,
because patch(1) doesn't set it, and using patch to install a kernel is
supported.  Therefore, this fix involves two parts:

1) Invoke the new script via /bin/sh, to fix the problem, and

2) As an nice touch, make check_config.sh executable as well.

Link: https://lkml.kernel.org/r/20201003002142.32671-2-jhubbard@nvidia.com
Fixes: commit 30fb9454ab23 ("selftests/vm: hmm-tests: remove the libhugetlbfs dependency")
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/selftests/vm/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/vm/Makefile~selftests-vm-hmm-tests-remove-the-libhugetlbfs-dependency-fix
+++ a/tools/testing/selftests/vm/Makefile
@@ -138,7 +138,7 @@ $(OUTPUT)/hmm-tests: local_config.h
 $(OUTPUT)/hmm-tests: LDLIBS += $(HMM_EXTRA_LIBS)
 
 local_config.mk local_config.h: check_config.sh
-	./check_config.sh $(CC)
+	/bin/sh ./check_config.sh $(CC)
 
 EXTRA_CLEAN += local_config.mk local_config.h
 
_

Patches currently in -mm which might be from jhubbard@nvidia.com are

mm-dump_page-rename-head_mapcount-head_compound_mapcount.patch
mm-gup-protect-unpin_user_pages-against-npages==-errno.patch
selftests-vm-fix-false-build-success-on-the-second-and-later-attempts.patch
selftests-vm-fix-incorrect-gcc-invocation-in-some-cases.patch
selftests-vm-8x-compaction_test-speedup.patch
mm-gup_benchmark-rename-to-mm-gup_test.patch
selftests-vm-use-a-common-gup_testh.patch
selftests-vm-rename-run_vmtests-run_vmtestssh.patch
selftests-vm-minor-cleanup-makefile-and-gup_testc.patch
selftests-vm-only-some-gup_test-items-are-really-benchmarks.patch
selftests-vm-gup_test-introduce-the-dump_pages-sub-test.patch
selftests-vm-run_vmtestsh-update-and-clean-up-gup_test-invocation.patch
selftests-vm-hmm-tests-remove-the-libhugetlbfs-dependency.patch
selftests-vm-hmm-tests-remove-the-libhugetlbfs-dependency-fix.patch


--------------E9109043627EDAF5C3FD96C7--
