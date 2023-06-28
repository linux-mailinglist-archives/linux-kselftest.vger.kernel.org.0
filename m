Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB4D74195C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 22:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjF1UOk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 16:14:40 -0400
Received: from mail-bn8nam12on2094.outbound.protection.outlook.com ([40.107.237.94]:43744
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229936AbjF1UOf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 16:14:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MA30aATvz6D0JiSBc2n93u/iier7rhQdJ4iv6zezH74uqumUEWqaFnwtsuzU9HAGVHRv51MbkdMuABTvHwA5EtBUeSfLW9AAM0QzcVEQI51fN56IOFG4pw/28V9qx7OfRaqzdbzptwxp8UkUOjMJxBlHqZXG/PvLBZgjWIgo6/uItg3Xx2kj+YnJBMd+i1hP/evAjO2QR8zHYMqmCEqn3fONfMmvAZVPOOiMfLj5QSpmLMl1KSfHi2v+1SGviQ2byWXPYls1ngv2sy36lC3KNVee5dJ0wlMzDM65beJJPVHhHSM+OdRhM0gLQCaBGXK6TXeSeNFoe8jVfxUnIGeh0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L/YDrIk8JftV8g6hYcmHUZk25zK0ulgImYWEtdvskc=;
 b=fV3zeK8T3skWYSZnRzPeJRtz1EDuF2REXvdUZ8ORvdvD2bUb3EwmfFx/2IVH9GDtYsU8DKfgTB2OtIilW0KLIwp9gcnKQR5ZFQUW+0UGidFv9i5YIGxO0iDSaFyEC4VuvTzD8qIIEHLVDVdquHPLrhnTt/xZXW0lVBa4IlzpaANS7KAtCw1y4/fcguPtXjcQ80VX1ROscHtwDRHAvcBTATdQKs5FBLXJWNuvYNSOujhvvqsCcImRIe9iUAjVgb38mGPs2PE6pOsx5TfW/Zs2htL8sSqogTtx51LrMWBeR4KJjkV47niI9n+bOshyKE3d7w6P2HS+h0JhJVTh7s016Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L/YDrIk8JftV8g6hYcmHUZk25zK0ulgImYWEtdvskc=;
 b=eN2oKJ2Z0cy0P257U+a0P2pWlW6CKgYVIzd+LPXeq5cpY681ruelfQYCbdb6fmSkiaHKgLD/8RlKhDAief7EfY44LZ0uWCZXl0VWQFge2e1hKy/Kh96Lj3NW1n5bGwUM5N6unLw4EHvOHGMwWvAQ5gW0IkTiLF9RsMLK5zGKXx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN4PR13MB5358.namprd13.prod.outlook.com (2603:10b6:806:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 20:14:32 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 20:14:32 +0000
Date:   Wed, 28 Jun 2023 22:14:25 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Aaron Conole <aconole@redhat.com>
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        Ilya Maximets <i.maximets@ovn.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-kselftest@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, shuah@kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next 0/4] selftests: openvswitch: add flow
 programming cases
Message-ID: <ZJyUoSaklfDodKim@corigine.com>
References: <20230628162714.392047-1-aconole@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628162714.392047-1-aconole@redhat.com>
X-ClientProxiedBy: AS4P192CA0047.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::19) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN4PR13MB5358:EE_
X-MS-Office365-Filtering-Correlation-Id: a0bb0f2b-2b38-42f0-bf8f-08db781448f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+xcgp+e94lPZEH0loiq/s2B4YH0sbO3Ljvptf2o5Lx9xgTSH5HO/PdieQDu7mWEz0iQp/sdEvs04dUEY7aEoZ7O080EdHgMFQbOiu5mkpWwIieRlDDiHbNfmNfCtUTxWujskEajovCJwUkSFwZZPBTKZtmBO3Psa5jeCRpE6w5lVizdKKoanMlITnllq+XGDyxOT+xrO59TXeHvXFzecwwV3yQlcv+1+v1Qy0HZ6L4TgWOYwYnCtgGkXhjoXwAP9Ne0oDU8UnN1pZ0H93NN5DnmmwjloQknPnZ1cE5mZ40uEte9lGfiVrXZsgQwyIVXayBctTvzBYyMqDwXCMhd354NXF+CavKTqQGIj+gGyp6U7zjM5yxDoBM8yB6Qm2UE1iNWzW13pNX7WfgVA2a1GRur/OXo9bQw4O+KFTRV4IflcTgRuG9pYWbtfgUX+5iZKhWJeNAvoNxOqsvO9Iwu+UD5XCO84CehAxHyhZtvYU0JozekIuY+JMtOSX/aa9+IGOADw2dJq0z6xXQGxaFmHOVUhgHtIfxSGLyS8ekASQ2XqzUdXuDV75TLvhQwExnI6HiV0vgais5/CRcC9RFS4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39840400004)(136003)(396003)(451199021)(4744005)(966005)(6486002)(2906002)(83380400001)(38100700002)(2616005)(6506007)(6512007)(6666004)(186003)(41300700001)(86362001)(54906003)(4326008)(478600001)(66946007)(316002)(66556008)(6916009)(66476007)(5660300002)(8676002)(8936002)(36756003)(66899021)(44832011)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f7Up66t8zvtEtpaoNbIG3k1Ty3aCrzinqtGKhwCPnEDm9mUcQrU07Ta8lKuC?=
 =?us-ascii?Q?CgXapDm7aw+8yfPmISyIOsXGHjsPStbBTnBvA6E/5+DKpMUXIpOVwIv/J5Dl?=
 =?us-ascii?Q?huK5Xea1ZoYvTVMj7OBN1ea90AhNDfbENY+9lmTbz5kFpq6ek6/iqdLgX6Ca?=
 =?us-ascii?Q?6epZgqiwDimZ1CGlXn9fVPSrEeuAXHCK9NBYTktW4V67UiruSP8edT68ybWo?=
 =?us-ascii?Q?tWmuP/dK2lIdZfeYLImwdnE1505a/Gx6GW2ndS8jblJNnHOwEb6VTy1T/CbO?=
 =?us-ascii?Q?jcRqVbTIBHZvSEFOpTSNU87hGd/Vl6VzHObvhMBYMHxW7O1zareoB43UThNB?=
 =?us-ascii?Q?XIiWfbYPUY1Gaa9cQYUFyqOT9JidTvjm9JAtDyVUD5cSEEW58C2DsJo2K0Vr?=
 =?us-ascii?Q?WwoDVkaxOdkogfi78K3ZwrY7hKNu8yB7F7ZBnAYgG58iz+1pFZqEvdUIqsAV?=
 =?us-ascii?Q?8WlSGGRZCerVk9ZDYzhpmMpQgwMeYdin1DYGWQhg7hcXr4g9L9JmU5f3LxbE?=
 =?us-ascii?Q?sVl7BU4gQQsROXPksI18MsZDzUqNaC5Ejyx6QHVTetcfR3eM7yhcbuL+/7Vh?=
 =?us-ascii?Q?ogQ6fdO9vatpFYH9YziYX+SIB8qv1HlxEwSL2H6IzTtIngSmdEd7JiHGHdJt?=
 =?us-ascii?Q?+wWD4cN9ku3Gb59XKgleFAFD7v+oM974VNF3XN2UTGuq28rwtDRatdXw1iwO?=
 =?us-ascii?Q?Wovu5lH7Zmqi4QhIpU1eLgwj5Glo4RKgSSuSrX0QWYXeZSEzEOyKsmsVVj/j?=
 =?us-ascii?Q?dbo9Xb9OSJ4RQJPvI6zjzvNGePVoiE5pVoMJiRxptrhY/nNY7ekA2DMMGXvv?=
 =?us-ascii?Q?fSmubQUKVbB2Q8qe6T2ZpEaq7QE6tyGTDvHuOoy9DIxpQVg7EyHpLU9ZOeub?=
 =?us-ascii?Q?TZ8jit6Djus4kogSTQvhR7686vA8xrqsARK8BWiU9CrquE+MIMPcPI/0r0Qb?=
 =?us-ascii?Q?gNwRc3E5aF7sX7gJY8d+GXkaYbsoRCL4FdCaWpFU03p9AgName2sEeuoNQkP?=
 =?us-ascii?Q?88h6vSa7Q0DQMiEsvGF1naSrnYwcuExq5EjIyYKRPNvNz8hFbZwyw90Ia+Yl?=
 =?us-ascii?Q?jQwwaq0ESFjTFhE08q+G/XCFDB3rfuTZiD+lVBKsxFRRw7C1TNjL70YhcByq?=
 =?us-ascii?Q?MQkqFuozG6WYbfra0tY7F9eRSvxNnB7fjcf45ajONKkr2y+gq+G+g1p8Y2cI?=
 =?us-ascii?Q?WlRLu/TXDRYsIeXRtxF1bKcPMa/3n/6ZAorjdff4QmkPR54lp5Jwd5J1KNgZ?=
 =?us-ascii?Q?fAzsHyuXbki4IG98ZFx7pN/SwQofv2PDSxYJ+TqSV0BRerxfeTN63UBD0Azc?=
 =?us-ascii?Q?R52J+MxjEmpf83kjzRtus5tYl7y061jIRgdE02pBzir9VjDSEvNP1UrJDhTc?=
 =?us-ascii?Q?z9wpIOPf5QKh9yAHMzF7qIrzN7kKtGlKWUYW3wSnwjyL3MHdgqXvgI+Y1qLU?=
 =?us-ascii?Q?t8J6mZw1Yr0SgbVvo/2gC/pcXsKtLKtQlypitjhHDvEnn1e1hnDoY78Sap27?=
 =?us-ascii?Q?o781g3L6xBcbx22WJsJHzqtAaFD7k2KMmAOAe4y+NFxFcWVdtS4A/RNNbUvc?=
 =?us-ascii?Q?b7qBx5nT9t1KY8onockhvieY3NT77ASsw5RIWLLMDiTP7ryt3mP1IHan3At3?=
 =?us-ascii?Q?aM2kI6pDl+TkoTvxHz8ZG1JlFjt0l6TizF5SHaRkhuT/WxdjJszUJfFR53jf?=
 =?us-ascii?Q?q0NydQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bb0f2b-2b38-42f0-bf8f-08db781448f7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 20:14:32.3371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOJaqsxajYRtMC6YSV5aPjWg31037NEbXX465ZYtp7TYLJMPpoXI171/pdh7KJHy3L4gWrwmhuPU76z6vRG0491uE30S+2bmcWQ4+Hc1uGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5358
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 28, 2023 at 12:27:10PM -0400, Aaron Conole wrote:
> The openvswitch selftests currently contain a few cases for managing the
> datapath, which includes creating datapath instances, adding interfaces,
> and doing some basic feature / upcall tests.  This is useful to validate
> the control path.
> 
> Add the ability to program some of the more common flows with actions. This
> can be improved overtime to include regression testing, etc.

Hi Aaron,

sorry but:

[text from Jakub]

## Form letter - net-next-closed

The merge window for v6.5 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after July 10th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer
