Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CCB1AAA81
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 16:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407810AbgDOOmT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 10:42:19 -0400
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]:61607
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2636742AbgDOOlg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 10:41:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ex+0SpgjWvUGBYW12OhBAwYgg4VxvsW4IuQleWGEqsnxAc8qCrMDbbOy95AnxnKmf+nsGZ+SUkF8fHToI8eISpRoCmCDOox9Xw2AVQ01TecD28rMa3KaRggtS/10vdei26iqFUVDKK+JZO0GYDUgy5jnJQhrkA+9OZ0eUeN4hhqhd76kzKZb+IqQf33aeBTUSsY/+ogA6jSD0BK4v4cKtrGF8hxSxV0/XZsxdg1L3LnTcw/t708pmQI/+vGKRBPkwwpXTqlzfa7I+7OFG5sQ42Yk/MoBSc65dvN7cXyzR+iSzrx5nCdTcB//DATftr8RYyhYVOFd+HidpTOO5rGZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN5QnRcedVZTuVlK057N6B0N5v9K0C2AFFtlJG+C85E=;
 b=OfkLgAw+wx29DLhHrSWcorAGJXIQx0/cgMtFYhBQsxJbb19uuVDjdwmZavM1VE9xQkBblL9OlBYNIbKevJ9PejXC7WlZSq3Yi7CRqBlqp6X1Y7JmXEgQx1kFdk25vLcUL2Ojjr9mjy5HYwRZBn7av2hupOoPNK9EF2NLcPwAlWBrvQ+PB8MTl1IPpmWprxJrgOUXPyDGVWkqYzUTpVDiJANaSdsbRU60ghF9vYB/qgTYnrTbP2/xJMThIEufd8bVoevCWa972ogjHG99/QsRtzkbq7/+eLumnybbPudbu9BscTSl5y1nPTmWA0AEl/7M1+fio0yO2cG9N/5TpNK3yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN5QnRcedVZTuVlK057N6B0N5v9K0C2AFFtlJG+C85E=;
 b=fxZIjOVQQIYcH1JUGv8SkKrnYgWbIqs9hxTJn3naT8eLml5sbOffS+9JD93TNzd783CO53jNbxgWnCB/wdQKMslCJjeRpw4598STmxJPufKwkpaIyvOb/73KsWbXfcIeUnvZ+OCB6Ssys6evsgXUucd0MnvXorQKDfawiJGAZsc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB5533.eurprd05.prod.outlook.com (2603:10a6:803:96::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 14:41:29 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e%6]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 14:41:29 +0000
Date:   Wed, 15 Apr 2020 11:41:25 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 0/3] mm/hmm/test: add self tests for HMM
Message-ID: <20200415144125.GU11945@mellanox.com>
References: <20200321003108.22941-1-rcampbell@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321003108.22941-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR19CA0055.namprd19.prod.outlook.com
 (2603:10b6:208:19b::32) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR19CA0055.namprd19.prod.outlook.com (2603:10b6:208:19b::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.16 via Frontend Transport; Wed, 15 Apr 2020 14:41:27 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jOjED-0007Uk-5I; Wed, 15 Apr 2020 11:41:25 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 032dd051-1370-4d2c-6a22-08d7e14b1481
X-MS-TrafficTypeDiagnostic: VI1PR05MB5533:
X-Microsoft-Antispam-PRVS: <VI1PR05MB55339E3891DBF7E4FEFCE2D5CFDB0@VI1PR05MB5533.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(66476007)(1076003)(8936002)(52116002)(81156014)(8676002)(9746002)(4326008)(33656002)(5660300002)(66946007)(316002)(66556008)(9786002)(54906003)(86362001)(7416002)(2616005)(6916009)(36756003)(2906002)(186003)(478600001)(26005)(24400500001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YpBxg11EYDmValOU/rCKBsdsr9b9/w/QMIGMupqMlQHq5mTeKy1W3J2Hnza62QrRutuO8PfpoWeXSEPo0shMg4i/PJS0nU1eqgsTYDFgXc3vtbPYKPr1UsetDtFSxUPkSQ+4pdhR+C11mFhjHxFz9Hy4YLgCkHmLMWx7JQi8r58XNiZypKH0sJN6n/v48LOqWFgM/EupckYozNGhpRygbFspvG/gKQ7YHilL6lJC+YIF/CH6alAsAATKike9ERQ5IydT19xdEYlkmMjWbIo7kgCBpVnTgaxwtHLRBbuETNOtDvqYDleDHrqKyvQa6xvLPh3UXFtGN/IqLDxh+a761ThbbyvRxeO+FBktJLcOloOZ8BK0QDDgHkA+pJNKQBpU+CJUIOu7enQ7IvPP3TlMKs8C31VrM7cEWAxulAe0x9LOEoNHmjHRXTIL1fS5eRtqYed8WGGsw9xQt8rzoH8VyOA+4zHddtNjhf9l8Z07nH77um2VOT7MEeSGQMfC+vaY
X-MS-Exchange-AntiSpam-MessageData: cqSvC6QoY+WBbpkLrhNr0uopG/avHTbOW1kLmJYRva2rtt02/q6NB3iIwusTj9vBAJXuUua9peVN5j+vgUI7K2wZ+sGLXl/KtLzCUWCfjYi5R7cwPhg4liNfSJKxtmeFDgGHh+h0TTrX/DDMWKBdGg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032dd051-1370-4d2c-6a22-08d7e14b1481
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 14:41:28.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xZ/q+/oN3DXhbq42Y9j169NR7GypD8m+tEMpVLiXf4aKy1e7DqcEJNfbwDXwEWGYVlvpVl5EoftF3CBzK+NIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5533
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 20, 2020 at 05:31:05PM -0700, Ralph Campbell wrote:
> This series adds basic self tests for HMM and are intended for Jason
> Gunthorpe's rdma tree which has a number of HMM patches applied.

Here are some hunks I noticed while testing this:

--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2201,7 +2201,8 @@ config TEST_MEMINIT
 
 config TEST_HMM
 	tristate "Test HMM (Heterogeneous Memory Management)"
-	depends on DEVICE_PRIVATE
+	depends on TRANSPARENT_HUGEPAGE
+	select DEVICE_PRIVATE
 	select HMM_MIRROR
 	select MMU_NOTIFIER
 	help

It fails testing if TRANSPARENT_HUGEPAGE is not on

@@ -1097,6 +1071,7 @@ static int dmirror_device_init(struct dmirror_device *mdevice, int id)
 	spin_lock_init(&mdevice->lock);
 
 	cdev_init(&mdevice->cdevice, &dmirror_fops);
+	mdevice->cdevice.owner = THIS_MODULE;
 	ret = cdev_add(&mdevice->cdevice, dev, 1);
 	if (ret)
 		return ret;

The use of cdev without a struct device is super weird, but it still
needs this

diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/vm/test_hmm.sh
index 461e4a99a362cf..0647b525a62564 100755
--- a/tools/testing/selftests/vm/test_hmm.sh
+++ b/tools/testing/selftests/vm/test_hmm.sh
@@ -59,7 +59,7 @@ run_smoke()
 	echo "Running smoke test. Note, this test provides basic coverage."
 
 	load_driver
-	./hmm-tests
+	$(dirname "${BASH_SOURCE[0]}")/hmm-tests
 	unload_driver
 }

Make it runnably reliably

Jason
