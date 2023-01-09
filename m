Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5EB661F56
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jan 2023 08:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjAIHjK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Jan 2023 02:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbjAIHjD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Jan 2023 02:39:03 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072AB12AD4;
        Sun,  8 Jan 2023 23:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673249943; x=1704785943;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bmKngTUFkcehKTz76B8NP/SVxnyvKzXSXXyF5Q+yJXk=;
  b=bhIS2TLmz5LohTDBvV/2m1eWNqmoK1x/JdcDprSmKkAiOMMH0zO3Nf+C
   v4QDU94zRUGwGQjflvgW2qvkv8xbrOiJWvBfYP+l7oK6gXHy98P2I4jVu
   yuwOThT5LVUW/ASMAj0rP212wyJ3pabMV3+AqNVAjjrJ4TFjgtsRB9ls8
   HrmSes7e/LkyxmW/mLPyNKMG9333OYdi/+gI3M4tBwJ34kcDaIwiyYH0D
   4HEe3WOaYfRJNczsgSCivuG7NWHSxEKa22dLlPz2tce8QrYOFd3SAUQZC
   VAODWmYo7NsFq1M6lN2GWR4wQIk9+MzznvJ2P2PlQ7TsTshDYKQtTdaao
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="321516291"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="321516291"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 23:39:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="764221369"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="764221369"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jan 2023 23:39:01 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 8 Jan 2023 23:38:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 8 Jan 2023 23:38:57 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 8 Jan 2023 23:38:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frCSfygg8f1ElUON7LYDT5ZPC3OcMLXQCkzmP8JkIW30qOv7NmHEIT4wBzoB4G6hETW50uweCVBZecY6Bh4KlhYRZiz8KfOkZ6ItS2GB29bXsFfOh0z5tkrkO4FmEgrfUyR6LnoMeS6/MSD5In2wZDpE3smKlVyhzMuNLmmxE0wnY0XUSIuwATokPFEnyLkAZOn8qXM/X+8XPLfiXNi8GACKwL9SZp8E9Up9TLBoaLKnHxErq5fM/BWTUDrFQ13+JY5K/BI2uqFPGwYSpcTE7QLHQK664eU8XQ5rHoDiysl3ecIF3HpYCC9xMqrgESU70m+x1abwlFtiobidqcGp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmRQLZXSDHLQzyCzzkoOcXaKZSu55iPnrrjAwicW6MM=;
 b=NRswON/YNG3tGKV1XcpL/U8aeWvYgNHYUbYDezBUyPgxywi7023wTowJs0ZkuxzTitroIrfRwn5oCb9PBTeVzOZSAjdLbljlG68RjHWliPlYhu+1CCRvJWxwAo90KmVpoSGBnsdfWTZZ0I3cF9AsJJObEzNorwXzi5RBMm0DDtRShvUWNr5YaJvQLnqG7vSkdIUb+CqxWwDZm8nIrOwGInqFLeaut5chsiXe0qg2J59oRUPLMpRWJH4Gr0SLXCm70PP6MsiUlYD8v0l0BQYr5CPXVBVV8MdVxNFR0HHA7upclqJCUeWJtQdL60GkFGjRmBTlNn37Mpt+IrlgI4uBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DS0PR11MB6470.namprd11.prod.outlook.com (2603:10b6:8:c2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 07:38:54 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::e478:cda7:b9c4:c457]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::e478:cda7:b9c4:c457%5]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 07:38:54 +0000
Date:   Mon, 9 Jan 2023 15:38:43 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Raphael S. Carvalho" <raphaelsc@scylladb.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Igor Seletskiy <i@cloudlinux.com>,
        Pavel Boldin <boldin.pavel@gmail.com>,
        Moritz Lipp <github@mlq.me>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Michael Schwarz <michael.schwarz91@gmail.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y7vEg/VHWsp86B6r@ziqianlu-desk2>
References: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1>
 <Y7bT0OL8RAWkCu0Z@kroah.com>
 <CAKhLTr1a+fTs2KyT3fm9yMxfjNwW_yLV7vRjrUXdNx8gfg8LqA@mail.gmail.com>
 <Y7bg5sxEZDIaGoXK@kroah.com>
 <Y7dypc4sFcmYlXQQ@ziqianlu-desk2>
 <Y7kqx5cBCVojq6QJ@kroah.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y7kqx5cBCVojq6QJ@kroah.com>
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|DS0PR11MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f39e340-3092-4d54-ad3a-08daf2148f52
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SR3hOdLfgiugyHQoJh7aTXJQNje13nDcL2SRLfQ+0jA7Ra9scTDmRvBq/8eWHLKNqQS3hsuJrwIMBfB0NVPn9J3gFouLmaUqomfRQdDEgxdSgTrDMDJiPk2NHnZSHEZ7ThBYWDsXOwB/Hlr2SDntOxHQHfG1AAmdCulfOhMlG5KHQQ3u8zLBqYANLzLXs9jhljD07lOJdUSD+oErAU5HrZS4KdCug10Id0EU6NRp0mH7H9Hb9E6nMoJgrtK6JuZN+q9lIAcputouisM5wbD/Lo/HQaoUTYhyqfxc5a4wCqRnXSKujwm/VL4VJTYzOPtWs1SXQ6lkuIAj2jE/oo1px5jnoYhOQXSc+gOp3OWgo/hGrcR/BCQfJ+DnqGogn3jHyp/m6HvO81DfktbqfR9mdygluBUeFSdrH+Ss4TfLajNmX54xTmzNlYa4cV7DS2TMskWShEaMTGaUOopj2Sw+8O/EQHDTc8/v+btMwMu1CW7aMYazslEirQ3v2p3sixGWqBarkWv2UFMBz0D3BZ/8NAxs5gOAsR42pZzm6QjwyKrJ3NRuXjQ9uZHBJ0CHWwQXXL6JcQniYn/zTFHHCb1XLuY+H+g9yzj7BcOHQ16tywSCdG0k6iRpsZphKu3ae12780FmNsyCMARI8PS+BMPUjcxj2ClR6MrVPNbRypL8Zbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(38100700002)(86362001)(82960400001)(8936002)(4744005)(5660300002)(2906002)(44832011)(4326008)(66946007)(66556008)(66476007)(8676002)(41300700001)(33716001)(6512007)(9686003)(186003)(6506007)(26005)(6666004)(54906003)(6916009)(478600001)(316002)(966005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UsOz6CiH0+klf9IJss7fPziVgVtjHmvvCWxNjwhoDTFBLEASBl97thKASy4C?=
 =?us-ascii?Q?2sTkjkqiHCLYgwZ7KW2/7ndVeFEIi6A0L8kMJDigJSIDqwHVtGkXCVjfoSwQ?=
 =?us-ascii?Q?+3fuwJYtt5oMEWUxjKkUafp5UjLHYEOZ2Ctk6YFHWyvRI5PMpGvxNcPTTd6y?=
 =?us-ascii?Q?wOeKP0mWyZ9g9MQA8zJGm4bZyqRli9rReTDj5b2bOTHoA0vJPSahDlGr+LGF?=
 =?us-ascii?Q?2+TqXS1rA/yhn1CkBwBb9le24xSPfcd66dMQ6MbFS1k93S6qaQuy+AC/vuWG?=
 =?us-ascii?Q?BzUMN7VV3mIH5qG6XtbJeAP5s8ag0YYPVOf+n8oja2IBOnGN+1RhZ02d9RLl?=
 =?us-ascii?Q?Zd9j/Z/RMcj9tD6eB/FnZoeYB/+ouKlYCh05HIbVdy6+OOnANsE9W7nQjmvg?=
 =?us-ascii?Q?Slb335Fj8mF3MdH0kxK/UytQ3DKquPPzSkQGLYWkToXQEbfG9tABBXP3GDj+?=
 =?us-ascii?Q?aiA9wLTskst39nPOiK1ri/2vIEZ84MGfLlsAeFamY27krfLmbp/FQZ9X9dzz?=
 =?us-ascii?Q?2kxFS+9Wp1duTJyIWveAPRI4u+hiFOCilsEU81zqGAe7CDYD3rS1L95aZxkR?=
 =?us-ascii?Q?MXMCAIuM9kialzAVIxI1W7BzaEkHay+NzVRPJXKIVfBlmMBG2tlAfGM6It/B?=
 =?us-ascii?Q?J6EsTRia/FG6bawz6U6gRdRwIvwLc5kkTOazEQ2CB4kdnSlNGhqGJKi+j1GS?=
 =?us-ascii?Q?OqtFT4l/TNn1kNs5Pd+E+C3FhjADwnIs/fAIsnURQWpiXGISkPh+m41/JHwO?=
 =?us-ascii?Q?JWoo+V8KBtK1xHd/mEuPSSxnTwo9c99yxIwaVAbKGJrTQ30B6otWeyft7IVg?=
 =?us-ascii?Q?S94TGtFmLtAkyxZtSb/EdzPpPzwGDwljS0VjYhzAMcNxjnCyxlMK3GesZ4vc?=
 =?us-ascii?Q?w9QkfZhO6fzDPuWhrskJYZ/PSB8+iWlxzmIqAniiB3Bqlk1DxT7GDlHTSZHq?=
 =?us-ascii?Q?EMq53PhTfCqoT5fiGpuCQl1Cl4ORbQOGKmi8Ntt+iZ6XHNku3MfxQ7tMPjoz?=
 =?us-ascii?Q?8+I0QuZ0FPii3bXMiqZ7P9DzaE5IUkCBhn87hOE8U/+dIvkVy/35DjftxUbs?=
 =?us-ascii?Q?QJiADz9ULkPzfUVsu3q44s5jagrOIRXmqmMGRTt1S9AHDcwNBcBJPLGyM474?=
 =?us-ascii?Q?xbD5gxeri/s3vontEXftm01eV07FfHK3SqQdth3PL+N4BTIOCWblh4uMmDMZ?=
 =?us-ascii?Q?tvtgl7Y9rmjQ2/DJde28u4TaiiYI7RFP+Zue7kZQxJ0gPKgTIjMVuhnPAskS?=
 =?us-ascii?Q?NNGyABXHxnnP9aKedDeQuZ8afwI1lJaLGBXtHOrumeG5xNtr4QvFq0S31C3f?=
 =?us-ascii?Q?XZGsOqZyVBo8BsCMrBK9iH4nsTfCg0iwnwl77B+3Cqnxn9mGZcMyqJVbTXBo?=
 =?us-ascii?Q?BmOqf8w0yVHgOMElLzjN2eMVDdAGxomHIElyNln2sLPdp+Zc0Z+kNQDeT4Vn?=
 =?us-ascii?Q?I1OTfawj08kkd7V4sVTYzDl/9FBOH01dcxwhbFGFTdja8sFP+BIEIoi9Rm0S?=
 =?us-ascii?Q?hANmb9t1SQZbesNpA9PmkH4ZEOk5K7nCW3CEcR4QujLZwz2jpCPCzIN/2L4N?=
 =?us-ascii?Q?+KB49vEWO2zDPxk3i2XjxJF19ixHn88D4JcMylJL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f39e340-3092-4d54-ad3a-08daf2148f52
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 07:38:54.5736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Q92i6/pGKueolOb7ly2Oz/myPR4QHYO8guJEXbs3NR6iRYEftJM+UhL5D3Edk+zHxUw0uxcXgAdZGjOoxUE9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6470
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 07, 2023 at 09:18:15AM +0100, Greg KH wrote:
> On Fri, Jan 06, 2023 at 09:00:21AM +0800, Aaron Lu wrote:
> > If you do not trust what I've done is what I've claimed, now the
> > original author Pavel Boldin has given the patch a "LGTM" tag, does that
> > address your concern?
> 
> I don't see that anywhere on lore.kernel.org, have a link to it?

It appears Pavel Boldin's last reply didn't make it to lore for some
reason but I saw him kindly replying again and I suppose you should
have received it.

But just in case, the link for Pavel's new reply is here:
https://lore.kernel.org/lkml/CABohvEPWBHmrRpZcQejTkZ+CYtYCyu6rFMd4doNn_CMk35um+g@mail.gmail.com/

Thanks,
Aaron
