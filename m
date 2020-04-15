Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8151C1AB1CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 21:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411813AbgDOTc3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 15:32:29 -0400
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:42305
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2633232AbgDOTcW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 15:32:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YA4g7HhgVGgHIk2efvhhpkJeT315VEJsVuPN/PtpCAuVUbNwF59B9V6XLSwwjUtOOwjqzWZftiPywmX/tFP36LdFgBB4ladrGANe6iNOcbsWUXNgrLADkw939zoGjeSABzjCfiqmNsuMm0UfRMFG7tI9EXOGRztAYzS08Gaghq0RUntWWlUow2gHJ+N7+g/VYkgRb4403xsak0ikMRNuQNdmYXYXgt7TDVUZsjC55OxYch2f8doPe0wNPSbwfr7D3icqyIdSpi5wXXyqnzDCMYV9CE3UCqYHw/KIp+bxHS84E8lzvgFOExeiuZWOKbOdK5B+yM6jBWXjoMXahkrauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ob5SR2nJG4mgaQEfonfyNmOibt39brx+1MdE9DQNMfQ=;
 b=m/egPBPlyyhTu5CA3zlkhZEN+JerkXcdGJ37MQc5s4Vu1XvEZYW+F+4V+w8QwECiMz0qnlI6WVriq+djY2PBiiWPzEtsV4r88usuyMzMyqoxmF9RruHBFds6K7+4KOU/TwvIDXcKvGMbzekb4sY1ig6w1MHxlJTI6OyGNHxCGUaQU7f/Q+w/ZNfPue/Q5gb3B7VP69hgjYfwbx2Yqvk5f3x2zfLcfUNsqqY6z5eSj4H9OmRSqEjn5T20FattRf+vdbrzfnnLSqCVVYh7i9oQ/6iOJbsLrZbg6vnpP4Tg0U9fY+3ZFP5DmPjNPzc2P+KCopHCkEtVAVElGDjw6alSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ob5SR2nJG4mgaQEfonfyNmOibt39brx+1MdE9DQNMfQ=;
 b=eq5jYTfwrghUI1lmSDO4Fp/tSFhbQJislywZoD5gzQyUhiTaHGsciOxANAXrTKzqk5Yw59pT7oM8r9x++Ci/j/Sep9I1K8a+UskTksys7WLi/YUBoNtM0INp2rkKFs9DzQJCZ3HbS8g70ISklILa9hIwYjeeqe+Hbk1QUY9soPs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6015.eurprd05.prod.outlook.com (2603:10a6:803:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.23; Wed, 15 Apr
 2020 19:32:17 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e%6]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 19:32:17 +0000
Date:   Wed, 15 Apr 2020 16:32:13 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 0/3] mm/hmm/test: add self tests for HMM
Message-ID: <20200415193213.GW11945@mellanox.com>
References: <20200321003108.22941-1-rcampbell@nvidia.com>
 <20200415144125.GU11945@mellanox.com>
 <6d7adb28-96a0-5dc5-e85e-68fca2db403a@nvidia.com>
 <20200415192952.GA1309273@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415192952.GA1309273@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR22CA0018.namprd22.prod.outlook.com
 (2603:10b6:208:238::23) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR22CA0018.namprd22.prod.outlook.com (2603:10b6:208:238::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Wed, 15 Apr 2020 19:32:16 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jOnld-0007JO-JG; Wed, 15 Apr 2020 16:32:13 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10b7f7ea-73dd-495d-2fdf-08d7e173b4ca
X-MS-TrafficTypeDiagnostic: VI1PR05MB6015:
X-Microsoft-Antispam-PRVS: <VI1PR05MB60150CF229A478BC39F04754CFDB0@VI1PR05MB6015.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(33656002)(66476007)(36756003)(81156014)(54906003)(86362001)(478600001)(5660300002)(66556008)(2906002)(52116002)(1076003)(8676002)(7416002)(316002)(2616005)(8936002)(4326008)(6916009)(66946007)(9746002)(186003)(9786002)(53546011)(26005)(24400500001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYtbm5deh9Lk+SRJlsXHobAzH1YlhhSFTHoNXNtLJYo7JpPFlGPTvFhuu/bfRVdln2vegjetdLgTuVy1hKiOs8IszUcc5/eIezHNHJLCdffhjC/S8/BFIQ3P0TP0+h2pPUBsbQudBbs6ql0EWOwCRucbR/lPQ3GAqeDFY70tahpJd2uSGvA9DEd8NdMAAaJSNoVOz8KtoGs5Pm55ID1b6lvPtynvH28+d+xGJpDAKtbH1YAWiAFQlnL1dDwfBLJGHXtoarKIt5sV4ysDbwidpm9NyjnhlJg6o9+KnHWUZAkry12qkY8caPbXPSSgTOEqwen+1dx0Z1YLhBaZndXsvLIe+W6q/yz2Zipy6OSkdZ9sKBB1MuqKlw3OimsJp2aA8Uh32SR5vI1aHN2o/wumuSkGvV7WHmrtnRs1nLWGesD+Www7RInq0lpxWb8pNC3IObLT1VMmB1Rv8IoW1CF9cD7g6vOYErg+tltlX01XiQR6BlSU8u1CabLZlLP7fo8V
X-MS-Exchange-AntiSpam-MessageData: oZxdiIm5VqV2uM/2f58LdRuWb3VQ2hSHHWt6c6W/b0VssMLtz/5EUDcn9DJfTGgrgCUBOjyaOI4/pVt7YM8P/1XxU3pCodxvaj/iBsNmKmzFKWA3tzhynuq633VyRaJofM6zylly+009tvGHqRdj+w==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b7f7ea-73dd-495d-2fdf-08d7e173b4ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 19:32:16.9101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjV2QfdSH77S/24USRT6e4fPZHIJqXNIydCdjXjX6TpUwTdQEIb9E2C4g3aakhA5xFkU13oFh6rt5H99ENb9lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6015
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 15, 2020 at 10:29:52PM +0300, Leon Romanovsky wrote:
> On Wed, Apr 15, 2020 at 10:28:23AM -0700, Ralph Campbell wrote:
> >
> > On 4/15/20 7:41 AM, Jason Gunthorpe wrote:
> > > On Fri, Mar 20, 2020 at 05:31:05PM -0700, Ralph Campbell wrote:
> > > > This series adds basic self tests for HMM and are intended for Jason
> > > > Gunthorpe's rdma tree which has a number of HMM patches applied.
> > >
> > > Here are some hunks I noticed while testing this:
> > >
> > > +++ b/lib/Kconfig.debug
> > > @@ -2201,7 +2201,8 @@ config TEST_MEMINIT
> > >   config TEST_HMM
> > >   	tristate "Test HMM (Heterogeneous Memory Management)"
> > > -	depends on DEVICE_PRIVATE
> > > +	depends on TRANSPARENT_HUGEPAGE
> > > +	select DEVICE_PRIVATE
> > >   	select HMM_MIRROR
> > >   	select MMU_NOTIFIER
> > >   	help
> > >
> > > It fails testing if TRANSPARENT_HUGEPAGE is not on
> > >
> > > @@ -1097,6 +1071,7 @@ static int dmirror_device_init(struct dmirror_device *mdevice, int id)
> > >   	spin_lock_init(&mdevice->lock);
> > >   	cdev_init(&mdevice->cdevice, &dmirror_fops);
> > > +	mdevice->cdevice.owner = THIS_MODULE;
> > >   	ret = cdev_add(&mdevice->cdevice, dev, 1);
> > >   	if (ret)
> > >   		return ret;
> > >
> > > The use of cdev without a struct device is super weird, but it still
> > > needs this
> > >
> > > diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/vm/test_hmm.sh
> > > index 461e4a99a362cf..0647b525a62564 100755
> > > +++ b/tools/testing/selftests/vm/test_hmm.sh
> > > @@ -59,7 +59,7 @@ run_smoke()
> > >   	echo "Running smoke test. Note, this test provides basic coverage."
> > >   	load_driver
> > > -	./hmm-tests
> > > +	$(dirname "${BASH_SOURCE[0]}")/hmm-tests
> > >   	unload_driver
> > >   }
> > >
> > > Make it runnably reliably
> > >
> > > Jason
> >
> > Thanks for the fixes. I'll apply these and send a v9.
> > I will also add missing calls to release_mem_region() to free the reserved device private
> > addresses.
> 
> If you decide to ignore my request to avoid addition of special header
> file to UAPI, at least don't copy and install that file without some
> special CONFIG option (TEST_HMM ???) requested by the users. It also
> will be good to get Acked-by on this change from HMM people.
> 
> However, I still think that include/uapi/linux/test_hmm.h opens
> pandora box of having UAPI files without real promise to keep it
> backward compatible.

It would be nice if we could put the header outside the uapi
directory and outside the install machinery

Maybe for now hackery some relative include like
 #include "../../../lib/hmm_test_uapi.h"

?

I don't see any sane way to avoid the dedicate module and special
ioctl though.

Jason
