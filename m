Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A692159606
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 18:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgBKRRm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 12:17:42 -0500
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]:9230
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727954AbgBKRRm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 12:17:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeHom/HJim89x3juCTtIqbU6zatfiIQFH4bLLQD4WZlyvq/x0OaIlfY4E5Kag8g3yi84MgbaSLlMJrQ91bYevKBxtX0BpQvFhAoH4mW+ds4r6uFQ/b6aZ/bBeC0nTUtUWBAXXt+BJv9YW9v+wBdM9Tg/AI/bEaiUN/AZ1QL1X2kC5L7kaAKeOdcssgF2ic6maY+hZu83TNg7fucvPppqyY04IW/lAp0oLorCVGP1tDamFptQ4D2YCVY2SCwvM8kMrm5E8XxhCzy4dd28oYcaHoHP29AmJ2cGHZqgZ8d4YHZjRd3jPE1R5LDilH/VNdxpY8NRmfMzxxaEiDTb3jt83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SokNiBXd71dtl3qu8pZM6zCc6wjMcp6v5Vd8J9tSyE0=;
 b=kfA1Vb2r9NJnxv2bemn/7Ei2b/Bb/P+WY+RcdAc0Jhq5bCJZ/vbJymSsF6bGrbYaDgljaZaXpJzhg9YfY3ApywfZg/AOjfMHNNXQ8KNo+1NIXkq45FregfuIsk5/mxIivWVFIIMEPPMpsIPWCNZGYG4xf14710QJTLkYgICjv/lM5o/WtDFMafV1eGevFgHkYgITqsqjPqx9x4qt4J4vvhrLQI+3tRbc+aXyCO7epOGrkEu/wKziQE6S3MysLfCoKWseb6Lt5i6VXZTQpneT3OSWAVJD+6Y1zM1mWf7EFBYEon3VTxPynSFMPlDi3Y0iTObTYgGPPmJ8xixMneYDsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SokNiBXd71dtl3qu8pZM6zCc6wjMcp6v5Vd8J9tSyE0=;
 b=XBVARGgmKnVn2apAtc4yJu4ZY0ejTCfjkbXWbaHv8jLHEqT+Tk032CuBBrRg0y8flCwp2BH3/QKiKnpBpVydaT+p1sCAYngLViwkwXMSmZgOM0lDeqYCTf2Z14IFJh2IRd5YJ9/UAtO5xgonbVnqQwn/G30nCm6C/6AGbk/3jG0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6093.eurprd05.prod.outlook.com (20.178.204.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 17:17:37 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 17:17:37 +0000
Date:   Tue, 11 Feb 2020 13:17:33 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jann Horn <jannh@google.com>,
        Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/7] binfmt_elf: Update READ_IMPLIES_EXEC logic for
 modern CPUs
Message-ID: <20200211171733.GN4271@mellanox.com>
References: <20200210193049.64362-1-keescook@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210193049.64362-1-keescook@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:208:239::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR08CA0020.namprd08.prod.outlook.com (2603:10b6:208:239::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Tue, 11 Feb 2020 17:17:36 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j1ZAD-0002g9-Hm; Tue, 11 Feb 2020 13:17:33 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 145f222c-729e-497a-c782-08d7af164a77
X-MS-TrafficTypeDiagnostic: VI1PR05MB6093:
X-Microsoft-Antispam-PRVS: <VI1PR05MB609342A30031A29D85922B30CF180@VI1PR05MB6093.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(189003)(199004)(66476007)(66946007)(86362001)(2616005)(5660300002)(1076003)(6916009)(36756003)(33656002)(26005)(186003)(66556008)(7416002)(4326008)(316002)(54906003)(478600001)(966005)(9786002)(9746002)(8676002)(81156014)(81166006)(8936002)(2906002)(52116002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6093;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEMcmxlp3Uaei2Q0PxVVqHsYJ7/CT24wOOwO5qT0R1rRauSyh15xQuFFp+/4/+j79UceIeRWvfV+pa1xc4cD4l8uiddQRSfw+11gI5rHBeFi50WTlBmwjI2kAHbQ6vyfbsd1L4/06CPLrw3datYqNajtglLh68muLglfw69pPp4nCYRcHFPZZBQfYhSnF3zD9CZ8HgS0LNG49Fn6ASjtr8sAoOhgCpE31piSiCZjpS9sbOlV/mEJtGQ6dbuy0Ci4fCC5d//2DDG4wn0NnfpGRIHSnK5lvt4Cxza49Q9reP5Tcvoc7+nJpo5LlZVIDnxVJsSsQkOuQ+hLgOf9hGIzMrqdQy4N+iCp+1OhZwVssDrzEVJxyI/13Y3NH7lYz9zdzvKI4Paa+7IRcP71/nhuGfvSdPcst7RYQjiAbFZpOlC487kFi1ij7VzttBHS37rWMuXoi2sL68TPRyAkXrZvp12UCcuqmT0p1aLS4bLTzmE6fJuHAhmajQzAXKuKdtUkk4dB2OVUH4GDkQ678ZfM7Q2dGb9Nilhk49l0YMmEMocJpZ1H9YHSsYfF4Oz2PmYc
X-MS-Exchange-AntiSpam-MessageData: 8qfC9zTo46UvZbNRiYr7Ik97iT6KZV3KR5u3FWPMnXjWmE3Y3rvR+lG21E0+cRe1hXvm+FBBWSO/iQy4+FywUHDc0xIFyccnJ8WE3h572AC/Ks3s1NSHOdBqXv4MJPAyqoVjShBYf+mwNUeHTgcNTQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145f222c-729e-497a-c782-08d7af164a77
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 17:17:37.2278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S46qNYUi4awAEUSW5flQxkYl0cfXzIHWh4mI+WpTTPNxkSJ6rF2A2ZsURuPPyiDJFpLQMc/ILuw2WG46Om0tZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6093
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 10, 2020 at 11:30:42AM -0800, Kees Cook wrote:
> Hi,
> 
> This is a refresh of my earlier attempt to fix READ_IMPLIES_EXEC. I think
> it incorporates the feedback from v2, and I've now added a selftest. This
> series is for x86, arm, and arm64; I'd like it to go via -tip, though,
> just to keep this change together with the selftest. To that end, I'd like
> to collect Acks from the respective architecture maintainers. (Note that
> most other architectures don't suffer from this problem. e.g. powerpc's
> behavior appears to already be correct. MIPS may need adjusting but the
> history of CPU features and toolchain behavior is very unclear to me.)
> 
> Repeating the commit log from later in the series:
> 
> 
> The READ_IMPLIES_EXEC work-around was designed for old toolchains that
> lacked the ELF PT_GNU_STACK marking under the assumption that toolchains
> that couldn't specify executable permission flags for the stack may not
> know how to do it correctly for any memory region.
> 
> This logic is sensible for having ancient binaries coexist in a system
> with possibly NX memory, but was implemented in a way that equated having
> a PT_GNU_STACK marked executable as being as "broken" as lacking the
> PT_GNU_STACK marking entirely. Things like unmarked assembly and stack
> trampolines may cause PT_GNU_STACK to need an executable bit, but they
> do not imply all mappings must be executable.
> 
> This confusion has led to situations where modern programs with explicitly
> marked executable stack are forced into the READ_IMPLIES_EXEC state when
> no such thing is needed. (And leads to unexpected failures when mmap()ing
> regions of device driver memory that wish to disallow VM_EXEC[1].)
> 
> In looking for other reasons for the READ_IMPLIES_EXEC behavior, Jann
> Horn noted that glibc thread stacks have always been marked RWX (until
> 2003 when they started tracking the PT_GNU_STACK flag instead[2]). And
> musl doesn't support executable stacks at all[3]. As such, no breakage
> for multithreaded applications is expected from this change.
> 
> [1] https://lkml.kernel.org/r/20190418055759.GA3155@mellanox.com
> [2] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=54ee14b3882
> [3] https://lkml.kernel.org/r/20190423192534.GN23599@brightrain.aerifal.cx

I'm happy to see this, I think it will help the situation.

While I'm not well versed in all the historical details, the general
approach makes sense to me and I've looked through the patches.

I would like to follow this up with a patch to again block VM_EXEC
from the RDMA related mmap of BAR paths..

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
