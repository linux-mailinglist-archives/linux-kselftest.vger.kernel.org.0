Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C792272A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jul 2020 01:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgGTXQn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jul 2020 19:16:43 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:29291 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgGTXQm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jul 2020 19:16:42 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1625d60000>; Tue, 21 Jul 2020 07:16:38 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 20 Jul 2020 16:16:38 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 20 Jul 2020 16:16:38 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 23:16:38 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 20 Jul 2020 23:16:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCoUoqegydEjQPyoEXbE2vGgNAd+b89o005xLH6jT+BeEYfXfLQ+fZ6sJ0tcSHxOCT/4WbP/jYRfaWDsRMDetDAK/w9JW8AzhVJuwtC3jSuH79dc1drxplHxephvhwmM8cjIpTys2EpQvO92ZZSp9IXVq17Pu3S4QCLyawJPV3oTeiQmWoH0VofHR2TF7eNkxVF7UlH52IICDZKJtcz5fG9aKEM5HYrmkuqeOcKXjlG3ev6QGgx9f2LhNu7j/RTbuFBMmEuJIcuZClxPxGvW8ZmnKjl0EismFUVMxByP1Ag4HbRtGJsvgkal+C88ms7lRPPrmp7p8Ha+ZVf4eLOitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9YsPERfWdF/nbq0WcQoLchDX/Y65JmOVza5hA+QpB0=;
 b=iAHcDGb0ZxLR6BMwJXvF02fuWLXg+By7QU1LcdcSFMLYVdON4ZBu8sUMU+LPbAXxkyvfKoqzTg3+E0UyOdVeIgvPWxIYznn67MsYKX+x628XKMy2vPKsN4W8WD21TQFhZGvylgnK17y8hHlwIPJz8gDcfk7PuIj9NS4Coo1zd5LoGPElheyI+W2cYlr39YB9vWPXUKLDce3cqQI+b6BmVcI0k2OYpLaw8N1Tqxdoi39MKfg7c+QtbZcrAjKkBNLA35HaXAFHZ3i3brCeOpvsqBOG2OI2nEfsqbgUz+Jep5947rEDWs5DiOcoCyqjpKa7yQpm/nRKTUgZgIUlBRw8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 23:16:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 23:16:35 +0000
Date:   Mon, 20 Jul 2020 20:16:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <kvm-ppc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] mm/migrate: add a direction parameter to
 migrate_vma
Message-ID: <20200720231633.GI2021234@nvidia.com>
References: <20200713172149.2310-1-rcampbell@nvidia.com>
 <20200713172149.2310-3-rcampbell@nvidia.com>
 <20200720183643.GA3028737@nvidia.com>
 <2e775a5d-9d62-de52-6799-3bbb09c88c5a@nvidia.com>
 <20200720195943.GH2021234@nvidia.com>
 <fdfde6a0-f2bf-c0b2-0283-c882aa755292@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fdfde6a0-f2bf-c0b2-0283-c882aa755292@nvidia.com>
X-ClientProxiedBy: MN2PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:23a::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:23a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 23:16:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1jxf1N-00Cvqs-N4; Mon, 20 Jul 2020 20:16:33 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4834a13b-0763-4ea0-e80e-08d82d02f235
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB311690C831D918EB185B363EC27B0@DM6PR12MB3116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1vdsr0Q8fmfyeG6Qr5xFJ847lTRIr1DpfMfQnCj+LmeniURZYRjJHNbLhc6dsuE5v8Ls7xMG/pAFrFAD52IZdIFH27Joivn5utBeXbiTWMfY0iNdrFxwEoSdlgMdVQoJGr0xzyf8e7/HpdCU9jq3B9+Zj/nf13jdtQK69s/IlIyib3pdeFm9oT+bFLqAN1fWkO8kIHyhF19mVo626dzr4WEl7YDampQPFnIMDZ5Youiy5KjXyP3rv4EPAwhVmPf/L4MlzeLh2hhlwNOqR9EaXoIAt7QrNRLQEJq8oLiOO3cH6Uev7HZ8ZriJv0rutVR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(6862004)(5660300002)(53546011)(66946007)(8936002)(66556008)(66476007)(426003)(8676002)(4326008)(36756003)(2906002)(83380400001)(2616005)(316002)(37006003)(6636002)(7416002)(54906003)(478600001)(186003)(1076003)(86362001)(9746002)(9786002)(26005)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tVqQxieM0fDVK4DPnAxAHf1QcCA4z9m9W0Sppr0hGem5arVxrqiyUHp5jIyZesdKD8Vx5ZSHfehtpdATVZq0vLfFwBx2hplbdeYcoDiY1RBYvJiqcOjkvEabTlRmvZHECQKGix9SIisrFs+TmUOIV983pxs96tuoEBpAp7i1nmuPRnJtwgaWhw6NWLrXodnmu9jNq9YEypGmakzkCB3KB+/fFQzREYCeujN619xUMKfjZ3Xw3sKm+W4zzlxwA2wVOwTH2eDVu+fx5TADYoG2tTKLz4f1RZ1DW3UWyIG+kZetzzRehdXS5/MZKHYrPf7sZitqzHx8DD/x/lTmA2OQ0vHKWJ71tr5Fm5PKXUOoMVQMrsYsq5BCMAubzkmVwrKRTAhgExKIvxq7I+mqXZBM2nO3QlG3Np162ycAScNjHxPJgjS5ozQP57CMkmh+upgLTCgfTZ3prABi6wm/8IDo2elau7LzHbNvW0UnA8WhD0I=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4834a13b-0763-4ea0-e80e-08d82d02f235
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 23:16:35.3146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQzMkKTH5jCxNqKMbV4jagMqTkm27z0xpJ9dQDXEAoi3kI9J29ZNfiGthw1jDU3J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3116
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595286998; bh=l9YsPERfWdF/nbq0WcQoLchDX/Y65JmOVza5hA+QpB0=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=NvGAOEXLF5Fo8nGP1vF5ypMJLmSXtXJxBtweEcANVnbCsNK91CDC3Ummnk6v/tzH9
         aBoXuMl1T0ygtIH+NA8x+xsLJWtQqSwP04+m3g8I5YMClFnyzW1ch+lU7yd4YC8+jf
         nP5S12gV7IQigjHMymTyuQ6kJoQMcMkBdE9MssRYEOCsgk5aXpgOGYAj+7SFWTtEmu
         UJmm0UvqBx/4f6EgszAedF3GUdEKbOz8Pmxom8UQN4wlVRJocTYB7Q9+t/M8BU50E2
         01S58TXDId7ZE0H3a2U7NfduR9KQl6n2bO6WPi6ImoYXBMA8EqfM9wLEoM6KM+86bj
         tOoToq6jhTfrA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 20, 2020 at 01:49:09PM -0700, Ralph Campbell wrote:
> 
> On 7/20/20 12:59 PM, Jason Gunthorpe wrote:
> > On Mon, Jul 20, 2020 at 12:54:53PM -0700, Ralph Campbell wrote:
> > > > > diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> > > > > index 3e546cbf03dd..620f2235d7d4 100644
> > > > > +++ b/include/linux/migrate.h
> > > > > @@ -180,6 +180,11 @@ static inline unsigned long migrate_pfn(unsigned long pfn)
> > > > >    	return (pfn << MIGRATE_PFN_SHIFT) | MIGRATE_PFN_VALID;
> > > > >    }
> > > > > +enum migrate_vma_direction {
> > > > > +	MIGRATE_VMA_FROM_SYSTEM,
> > > > > +	MIGRATE_VMA_FROM_DEVICE_PRIVATE,
> > > > > +};
> > > > 
> > > > I would have guessed this is more natural as _FROM_DEVICE_ and
> > > > TO_DEVICE_ ?
> > > 
> > > The caller controls where the destination memory is allocated so it isn't
> > > necessarily device private memory, it could be from system to system.
> > > The use case for system to system memory migration is for hardware
> > > like ARM SMMU or PCIe ATS where a single set of page tables is shared by
> > > the device and a CPU process over a coherent system memory bus.
> > > Also many integrated GPUs in SOCs fall into this category too.
> > 
> > Maybe just TO/FROM_DEIVCE then? Even though the memory is not
> > DEVICE_PRIVATE it is still device owned pages right?
> > 
> > > So to me, it makes more sense to specify the direction based on the
> > > source location.
> > 
> > It feels strange because the driver doesn't always know or control the
> > source?
> 
> The driver can't really know where the source is currently located because the
> API is designed to not initially hold the page locks, migrate_vma_setup() only knows
> the source once it holds the page table locks and isolates/locks the pages being
> migrated. The direction and pgmap_owner are supposed to filter which pages
> the caller is interested in migrating.
> Perhaps the direction should instead be a flags field with separate bits for
> system memory and device private memory selecting source candidates for
> migration. I can imagine use cases for all 4 combinations of
> d->d, d->s, s->d, and s->s being valid.
> 
> I didn't really think a direction was needed, this was something that
> Christoph Hellwig seemed to think made the API safer.

If it is a filter then just using those names would make sense

MIGRATE_VMA_SELECT_SYSTEM
MIGRATE_VMA_SELECT_DEVICE_PRIVATE

SYSTEM feels like the wrong name too, doesn't linux have a formal name
for RAM struct pages?

In your future coherent design how would the migrate select 'device'
pages that are fully coherent? Are they still zone something pages
that are OK for CPU usage?

Jason
