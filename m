Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1387C84B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 13:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjJMLla (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 07:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjJMLl2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 07:41:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CF3BD;
        Fri, 13 Oct 2023 04:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697197286; x=1728733286;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2VExaOfuSIH8zT/3/mIe5eASMIM3TAbotM4P4bdXhRM=;
  b=ObQ3DJD83bfrgdDb2g+jW/HqHy6pVVc+benNNM0YhxNmhhtu3wdFtxXC
   kC22TvTch5g8BB6UJZGLthHQTWgIpyeJGc4OWhGzltpFij3iUCY30cIH+
   EC+OUV7vxP4Q7vldeEVYce8pi+6nWZqcXBimAQKkYjItcUNQoKdZd5lWe
   o3zZikoni4cqc8dithPY8BaQC0fkSR7BhtP/OZQGJhmbizqKwvylyu/Oy
   kmetaT2JAaN82+5CSnVUD6CRLevCu5Ylw+kLn7qSIqYtm74ePPenx4rKR
   4I0QTt2xZx7NfEZbai7tVUwi4t3UZv4uB/PMWdS7B+5Bo30J82rOy8M9A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="382392584"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="382392584"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:41:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="928402386"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="928402386"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 04:41:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 04:41:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 04:41:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 04:41:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGY1TzqSuJ5BZkqnYqLUKvGqHtjJTN3oAB+B54jjZ5iz2x1fBSsQISzNXCZ7ENtlEXKnEJvGT/iBNwsAWq5NZFcLweXMK0x0CQX20eWbqPc6bAHxdVB58Ix4pERVUSAukzExmWytSoLGAyLyQlSIOjK41mxHp7g2UrmDWYgGCDOkyCGRoyPdck6VNrTRBUq1WZ8T0aKQMRaX4CdMSHIAN5TK4W+FOkrFZptgTaHwNYrqIzsVJUSRBAIiZLXfBGURlNuHWsAnDP15QhLFTzz+43xSxl0YPJs0Wqf0uHYf1RNCOQ9WeR3JykYNtFKMde3D270UwOa4/XP8FC6EM7q0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xU+KbutER7hFLTwWGfaq4IwyTYdQ6I2d8ymUvbVWxOo=;
 b=KLtqbycyObahdEydVufx6hzHg2ON3Ao1UjOJhfCK04FfIzSHggzOIEEapVx/vCu19qyR3fKpBFw8JapNYkHTanmToH20D5YysCGEayasSpaM7w60ZS4b8END5XCzh1LHC95wS5esWoXnEjaJsJltFs0B9zVj5XTJdhzjNkLXQW8q+ifU0Exn7UVpARagVtfEyDouXmE5f415zTS/zp9ANtyL3fsb7w+MJEfm255vRl/P/3+imWeH2VefqATUKUn7EEonvwrhTU1dEfKnYuwJFl9//n1wY7u2dan05/1Dl0RcSRqFIkWdbVobiDaRFxGZ1jjtvTbdE00sKa6ixsL6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by IA1PR11MB6218.namprd11.prod.outlook.com (2603:10b6:208:3ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 11:41:22 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3%6]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 11:41:22 +0000
Date:   Fri, 13 Oct 2023 13:41:14 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     Shuah <shuah@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/8] selftests: Add printf attribute to kselftest
 prints
Message-ID: <wi5tm3bir2ht3geaaa544wem45x5gcl5qm7yqct7xsvnufk5fv@ujcvvbexvi5e>
References: <cover.1697012398.git.maciej.wieczor-retman@intel.com>
 <13a47130763d109aa40de153ecbee9ede22d8356.1697012398.git.maciej.wieczor-retman@intel.com>
 <a2a5cb05-8604-4303-9802-573359c68368@kernel.org>
 <4h2eu6yhodrujbvem24v7cwal5tnk2agsqulpxwi4myk7n35uq@phbxlajivrpq>
 <fafe90f3-5612-4dac-8ca7-4f0d0d6a05f7@linuxfoundation.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fafe90f3-5612-4dac-8ca7-4f0d0d6a05f7@linuxfoundation.org>
X-ClientProxiedBy: FR5P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::10) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|IA1PR11MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: fda36698-e4f5-4267-231c-08dbcbe152d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGM2SF6G3JmIhScwuttBUcQdLTvwyBdvVy9JODIIknDZ/oN80GqMTenWf7q8wiT/M+64CMoqYRVr1gZ6xhpfIL0rGnGOECmUQRZDEJPOyvVnluu6b2eCV7xW7htLITLoqITDxLGu9IUug5t5LehRSI45qWCRehyuNd9NOX7UpVZwBRuUK/Tzxy8sVakE43Ji3ABmaP/mHG0P8noJPZxLD2ACX2QeNTca9RPRRCRaRXCGZcOb4Kjiu1M7zDzEYZrSn2oZG6hQ5r8sKAhrW9/DXeYS2WsFo6H1Rn6c6i7CEZcllxQ6BT6vUqEzXg/Iqa1FKcCGh6N6a81cCHHBzAjnEFYh/tRJDqvaPyS3mVezeP3i/11ZuUh6IlkJt//dKUKP/rA0PQ6YQQKT1Dlrazgrg26R750KrsoFGvKlNhpVM3MPHvs3Ud3YikaXS7BDWV4mSDUNNKyTbS1Q1fQKP+2GDp4ddglGQzCTwRFRWT6svZhajg/QqMM65H8gRxUDRjmWXDvVqQUCpabPiPsuQwjzqWncfv74uvbmT1CzHuvDHCUmmHwWiGfRpANIMmtVoTDc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6486002)(2906002)(478600001)(6666004)(33716001)(41300700001)(8936002)(4326008)(5660300002)(8676002)(66946007)(66556008)(66476007)(54906003)(6916009)(316002)(83380400001)(82960400001)(6506007)(26005)(4001150100001)(9686003)(6512007)(86362001)(38100700002)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?a9E+cOY7N6H6OHKxRlxz2LiEKP+Mat40/bY4MmLW6WqtXTpzTO0zKDsUW+?=
 =?iso-8859-1?Q?onmlnT2bPfekKpzqAX6iBo623U21SmUyiGs4ymEhxu9WnvFklC4gyxRZJd?=
 =?iso-8859-1?Q?eq5BKDCPU+5CbAgx2AVKegkc+hP1fBfuo+FxQNZpjKt1VWt/CCVIl4YXI2?=
 =?iso-8859-1?Q?fP5mW8O+qy14RiojlOovBQKWdXqBa+EvXo8YLT2DEQDjdBaiDKe1iy9oTV?=
 =?iso-8859-1?Q?VC6yyEdRtyT82BGcn4DgDBqHNajdVhY9An8510/LixrFMDcwPjlSaMKvkQ?=
 =?iso-8859-1?Q?DmimwNrC8DzFk67wC2Evq6JMHFcs1g+MCfZqmvrELGqbRz+HySJx9A37SB?=
 =?iso-8859-1?Q?Evok3XTBV5Sp/AKYOmAzR+MX2OjzjFQL6YGP5PhiZHeH+ZT8Hz3fYVfmE+?=
 =?iso-8859-1?Q?BFagTm2q8CdJgCwIfZv3TuGmNRCoW5rp/qUzliP3w33DLVWQQL4eDHANrG?=
 =?iso-8859-1?Q?L3Y8n/JFLy96QX7uQo1lucvi3ThL4TTgtpm1L4oWhXqQ9ON122hPSvw+tt?=
 =?iso-8859-1?Q?/GgIL1K4nM8XzJegeasgQOVOAJmCCAuOyzxwIhQ+evBWs8Dd6mOwcX9Wcc?=
 =?iso-8859-1?Q?kHDdU4JIoedzGbzwdNyDHh4yZR8YwaBAGz23nFdpHrV+XR34hWBDtGZVns?=
 =?iso-8859-1?Q?gtX7REIyaVL6kvAJxUziHeLBF9NLox3cmc6y6CqaFuZjrf/M03kkKsWhcb?=
 =?iso-8859-1?Q?bWS2/0mPj7wXirtb25YF8vi1cM7DSYIeRgBbd7PBQFA20XhjPrLcD2yzTF?=
 =?iso-8859-1?Q?ugQEKvTS8b/2H66VhQBOpx6ELOSP/hfGd5MiB7hKp3qJr+3bn5vnUM4DgC?=
 =?iso-8859-1?Q?3PwazUUkTgWzmwcwRhIF5B/QBo2Co812q44M8A8mps3uKyfopcjFHs7Ay2?=
 =?iso-8859-1?Q?Wds5PHWYonXtkaTIm3Ycvt8fIEghIVkIhtzH0HDuDR39zsxR+nWwyh8qk+?=
 =?iso-8859-1?Q?3RK4Bsaf/vcmfeXuIOyC2MqUwYeo6hyDjT5CbIHEjX/0ytfk7xz7G8nOHn?=
 =?iso-8859-1?Q?b/HNQvkKOmk0fSgcEl2NKdKhUVrxdOp3PSnkCN0svc+G9fgaHOr7AhKdNA?=
 =?iso-8859-1?Q?HVk2PZmZVbzZcIEu2naZcjakX3sAL1nRgHThwrsw0o7pvASupz3p4RIJui?=
 =?iso-8859-1?Q?+Zzw6EoRyC1Q7sPTTO6j3DqouiTR3Rfr0Bo1ZtnLssa3cYQQdgGVacneSO?=
 =?iso-8859-1?Q?DVnH6Kn/UfJIx+vT1F/c3jZfOWwvrwvly4hzulFcpiswBvZ0w+c8/StLQl?=
 =?iso-8859-1?Q?C1BhXEvVgTqoUNGgp2Z4J0EEUPGaSITxz/AKwcXOe1vWpfjCR1y5fUjgss?=
 =?iso-8859-1?Q?JQQyTZcuiuRLVrUDyF3K5bOJ6I9HZps+1fjitgxL0/eJkDOiwWQw7830b6?=
 =?iso-8859-1?Q?dPcWqZGfjck2nUGLK+2aYuVmCrBlKRCmJfgbLsHrRUVxFzONdaoc2GUcz6?=
 =?iso-8859-1?Q?A5aIsxoXzTyNucJwdSRKekUKLFzjVzl5DFR9/GpXPBcQOGOfcUoSqM7Xvy?=
 =?iso-8859-1?Q?mi4j6w60gFdeZv+7Zc//1Xkiznb9zJpfV0Um3z3YkWPzNbWg/DAA5rb2d+?=
 =?iso-8859-1?Q?7vo4YFnysw4FwXkssapdu8aprhNoFpWIoGVPGERVVJyIeyKTrNrogWcd00?=
 =?iso-8859-1?Q?Pk9uC3+j9LHLHVpP0s3z+uS9O1Sp6QFzYC+Zn1Sammf4svQO+9TogyMLip?=
 =?iso-8859-1?Q?lIexFY9ZUGYlZdQxU38=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fda36698-e4f5-4267-231c-08dbcbe152d4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 11:41:22.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/PB+LafledHjt2v6xf5fFYWNo0xhY3q4OfBGwjTryWhU1/KDkmIBf2mdvDVbelSXN33lCNMzpxLV/CWzF2oGtEOZlRbEaxnhneV+SLmfmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6218
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-12 at 08:30:37 -0600, Shuah Khan wrote:
>On 10/12/23 01:32, Maciej Wieczór-Retman wrote:
>> On 2023-10-11 at 13:40:48 -0600, Shuah wrote:
>> > On 10/11/23 02:23, Maciej Wieczor-Retman wrote:
>> > > Kselftest header defines multiple variadic functions that use printf
>> > > along with other logic.
>> > > 
>> > > There is no format checking for the variadic functions that use
>> > > printing inside kselftest.h. Because of this the compiler won't
>> > > be able to catch instances of mismatched printf formats and debugging
>> > > tests might be more difficult.
>> > > 
>> > > Add the common __printf attribute macro to kselftest.h.
>> > > 
>> > > Add __printf attribute to every function using formatted printing with
>> > > variadic arguments.
>> > > 
>> > > Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> > > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> > > Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> > > ---
>> > > Changelog v4:
>> > > - Fix typo in patch subject. (Reinette)
>> > > - Add Reinette's reviewed-by tag.
>> > > 
>> > 
>> > I still need information on how you found these problems. Please
>> > add it to change log for each of these patches.
>> 
>> Sure, I'll add notes on methodology to patches 2-8. I understand that
>> this patch (1/8) message doesn't need that addition since the problems
>> it exposes are in separate patches.
>> 
>
>Yes please. As mentioned a couple of times, I would like to see how
>the problem is found in each patch commit log.
>
>> Or would you like me to also note here more specifically what effect it
>> has in the rest of the series?
>> 
>
>Yes please.

Thanks for confirming. I went through all the patches, made corrections
and sent v6 of the series.

-- 
Kind regards
Maciej Wieczór-Retman
