Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224DB671315
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 06:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjARFUl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 00:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjARFUi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 00:20:38 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10E658294;
        Tue, 17 Jan 2023 21:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674019228; x=1705555228;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qQG6drFukuVNC6HHfrRGv+9NzV3Jm+Um9MS8k5PEEFg=;
  b=ZK7HqLaCrQtYoZqprBBuuceHD9M3Z4nGsjLn44FwUT12pBGBycaDelqB
   f/qalMbYpzEspga5AKoejYJUggS6+2Q1fegoZbdEHPRQduUEptBX4STOB
   HEB3QDdgUFx/VL1RdfZ+Vj+hUpT9BFrB8zX87XFRkUklOv9mQX/fF6TFs
   r246ToUBZdko5cZ6Ay1lWy0r/+fPX1LrHoyePc719MtUo6kRjl3wKnFHj
   LV++2EVEWaVkfzl4ZvhjlZb3KhiZ24a5alL7dXXRlXEr7hluJZoa+Ku8+
   R9xzJXJprOV6/uWHOcFNogWPOOxNMc4QqeDpNKA7DR1OPQi2Cvzdbyu6+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="305274480"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="305274480"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 21:20:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="637122736"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="637122736"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2023 21:20:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 21:20:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 21:20:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 21:20:26 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 21:20:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOINFv7e6PwqhS74UMRmNnHF1FL6DQKdMDs+JaBI3JZdAfxMrpABzwZRHJk7zXZu5MJzhU5Uw+Wo9Jo1ekOkouJgooUeCKOA/psuSpeWL51Bio67nJbCbb+KfedxbnrDn7Ki1c4dINYXjgfFiM7TEeDTRLiZnRWFlZHOiStdagNrzDelRGTnQVU7rq0cgrKCTzCpIPcQ3p2VqPxzy6IX7lQg36YeFqkg6DBb2WitXHTGgwTs6ZiJOWsglP0vHiBYvBBniuquHW6L6jOOPZyz1Kpiw8GU8s+Qz5hxcXg7rpFCu3u91c9K4boKrQ+vQGOKRgn5U2VsNWPJ9Fbqm3l+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPeH88LDz+HG684RYfm9LRYbrcFwKGkV7PVfDY2Y6f0=;
 b=N5KTPZWfAZSq67W8N0MotCoj8Q03nMNM+rU1b7yAonBY+S26Rs6axEZpuyK9kwuXMX6a0pZeH0hwd/LjnMLPI6hEKNC+MHdP3qujMryZfYKuYZFFQbBTzswXTZNqCB4F6KI7+swjFxYqMZ4emg/CBJIniOEDp82ycevnQSCsUhQUT9YpbBdmmdxYkaW86xHJy145jMHt40el0gC6k6bF50q8BB3e8524T42jmZEU3iK/x8mjWWROn2NLoK9dKP2fMEyaYxLGbtX6xSoCGDhDJceyVDRWyJ6kvdsE9lxVruQv/zkWAh8NDJoan44RcUm6mPMikZxCsDtFtk1ZHqXXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH8PR11MB6707.namprd11.prod.outlook.com (2603:10b6:510:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 05:20:17 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::e478:cda7:b9c4:c457]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::e478:cda7:b9c4:c457%5]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 05:20:17 +0000
Date:   Wed, 18 Jan 2023 13:20:05 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Pavel Boldin <boldin.pavel@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "Raphael S. Carvalho" <raphaelsc@scylladb.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Igor Seletskiy <i@cloudlinux.com>, Moritz Lipp <github@mlq.me>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Michael Schwarz <michael.schwarz91@gmail.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y8eBhaHgICkwR03N@ziqianlu-desk2>
References: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1>
 <Y7bT0OL8RAWkCu0Z@kroah.com>
 <CAKhLTr1a+fTs2KyT3fm9yMxfjNwW_yLV7vRjrUXdNx8gfg8LqA@mail.gmail.com>
 <Y7bg5sxEZDIaGoXK@kroah.com>
 <Y7dypc4sFcmYlXQQ@ziqianlu-desk2>
 <Y7kqx5cBCVojq6QJ@kroah.com>
 <CABohvEPWBHmrRpZcQejTkZ+CYtYCyu6rFMd4doNn_CMk35um+g@mail.gmail.com>
 <Y7vK4NDlpfvr9zA1@ziqianlu-desk2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y7vK4NDlpfvr9zA1@ziqianlu-desk2>
X-ClientProxiedBy: SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH8PR11MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: 394d36ef-9a04-431a-d03d-08daf913af92
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4ME5kYYZZKFga7EZG1j5RpDF6eN/ntvoD00fQklkF4M36GhPJWv4Luw2EEv+0kMAO1iIDQiYE6tWalWtyFZEOeQ2UDQRY1LNsupw7hz61z+3h+2+V+l87b9rC+XRpUFMTboXIhvUKPwIr0ufURs223YpV+qW8IqIp2HUEav3q5F7u2LNfSiBBuQv2R/ETbFx9IOwNB5PUUGmHJjVul7NOfDzlkGOd3dO+bLnKyyb8hPrDWgsZxHDNzCdPwu9UoAeeDvRuxjsZvQwflHKKdn1fa3U8sFGCxAAsIy9AwBDWr12NClOVudNn+NvHmHHZHH+5u1L/6WcBKVjOQ+YO/uNyfROmH4B+uj7Spp73CPy08TOv3owdv+j5Qk8ltm/covyXgqmmwgJxaLnzYU1b8hV0aHgY1xcBa7FF3pL7axPi238MLS8AEDEwrNI+fT/947IYMoPaFaKHZ9fPEs5Cz70k6onCOb50MYvYjCf3j23cSWfOoEYdVx7D/sZQzMM0Caoeoht5W1JLWaOn8uAxW4Ko8Ek9WbvEwg8MAmgIA+qTpPuGT+AkkSANPPfdr+bXAqLLzQs/JecGn+tuI9exXa52GIDNhCl0jBsLRG5ubvoG/VdgVOQ7RMO2yPQVRoNXkPRmuSBUtmiQ/auU0SthNV1fdtgWdFFB8w41rjLSM0UD0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199015)(86362001)(4326008)(6916009)(8936002)(8676002)(66476007)(66556008)(66946007)(5660300002)(2906002)(44832011)(38100700002)(82960400001)(83380400001)(6666004)(478600001)(966005)(6486002)(316002)(54906003)(33716001)(41300700001)(9686003)(26005)(6512007)(186003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+BW1G/DWKuo587lvRidXfl0BsOQs8c61n+MuPXmI3z0pOtX1Nkaq4PFB9HbA?=
 =?us-ascii?Q?rSCyMA5d14NKtzz/KRT1yMM6AOYLjVwx7eaaWMvH32DLtlBG29fzsAyavIXV?=
 =?us-ascii?Q?eH68DLRGL9wQmh6nl+CywPuj8mBwxUp3Mm9KnhwWTxVZOzTXvsrwLDYmizMl?=
 =?us-ascii?Q?ctCZq67O8bipav6bYNhCoUjizKe3G4ibBTruYAwV5hSR4yefUEXt75W35MxU?=
 =?us-ascii?Q?6pEZj9q0i14Py+sYidWIwFbmoomqupL2tSHz+uV4xMlWIRqNlSQRKgKDuH0T?=
 =?us-ascii?Q?Jv7BilOdVErJ8uxRWgydrxEtcDWQolZyltPyRsiTDvaUw4XR5LlHpAxZLtOo?=
 =?us-ascii?Q?Yv5D9me/rOtBVqvTTfVEZtLaTomUzq76xVCSwV22UXVHW0IFdZsbddy/Ti0y?=
 =?us-ascii?Q?MDgAbcRpkCXeJNRt4+QQryjjFSAcz9tMT34KStzo3ESpu1B9DpDxqcJ5oSjn?=
 =?us-ascii?Q?LABXp7IKdNfC8SDMJ2RT7vD3pZDQRVgcAsh3zW4xtYKxSGSl6y1B67Z7ouRQ?=
 =?us-ascii?Q?QOWuwbFu7H9X3Bvz7bwPQsf/us4OArhhhW1AgQ1np0GVP9t9+rj7NUJBSXXU?=
 =?us-ascii?Q?ktP/VZrbsWDUa/IZt2uy2XRhqUbmC8y64lDJ6CGiHClrTgef8zgY9AI78WQE?=
 =?us-ascii?Q?g0OX9shLaDHVxPNDONEjeqsZ8ug2T/KW1q7B/MAb9kcO2tDqJ4cUCyl7whZj?=
 =?us-ascii?Q?vep9aXljRvzgVA7HkaylMZRx3XKZHHKatG43xpkoy5B+iu7NLStuHQAWGXUm?=
 =?us-ascii?Q?Ni5RExp6ggdpqr5/xSFqUi9o6FYdAKuvkzPphfPjcfl5lSFasmFeSWOYztOE?=
 =?us-ascii?Q?0a38MFzE/uO7yAm3Tp0fro5AYBGHig0Q1wkSnknH01rMXNGBP6d6EFlCqaw+?=
 =?us-ascii?Q?9yHRJNWitz7kRHcBpA+xD7CrYYsAhgbNBwKncS86Y0DFXzsd+a0+5OzkN5mH?=
 =?us-ascii?Q?GnwnVrTzJAmIA3qMZEhktVxgq/hXd6a1OLexaYh/KAopf9ldkmd5zBtW/ffU?=
 =?us-ascii?Q?ubtBigx0KG08aoxqPAGPaOAyuAPnhcNq9j7QmxyJgUGjJkeb1+ZmB4oj9+8E?=
 =?us-ascii?Q?CGAyO0D2wPNuUlQMHZFwLc5NhGF/WVV88Hv1rS5iwx2B5tKfzqViXHyHhrcw?=
 =?us-ascii?Q?nybJbAkShbDL/fK3zLTGjDhEjuv+0OmEYzJDhqk+x3P0IwL9ZxY4yFOKVG9A?=
 =?us-ascii?Q?vUPKgnvFvbs6WFxvC3u1SoeuzAAtLANtAZ4E4SeUkPlNkJMPfyiJFx/QQSKL?=
 =?us-ascii?Q?Ln+d7jzvVsiHR1kuBcDrm/QgrPoVU7CKZN6JxpgqbXQXItsGopKCaPoR66UI?=
 =?us-ascii?Q?VRflTJDXn6PUp1OU6uJxpCLnP+C5hUYykulzqixxlb5Z/rLSp+6wGcOm5idF?=
 =?us-ascii?Q?qa9oozcrIyvSD2vSEU3UA+20iSR3ufmxO8IgF3x8YlJRd4Bfo4QRzOch+Knv?=
 =?us-ascii?Q?poBaHkazYBLOSs3nxt3bOe7V9plVUsVv4Woc131hHGRdGqNFcAfSljTlj0PR?=
 =?us-ascii?Q?MX3pQUwKoUhAC8DG+t/6uUrA0+v6HLkymvUJ4oXWx7eMpXXU33BV9M57TUvC?=
 =?us-ascii?Q?708ESXdQViCkYpU3XEytj6AzseLg8lAIzs0VcTeV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 394d36ef-9a04-431a-d03d-08daf913af92
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 05:20:17.3550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Xvkld8ZF3N3Exk5hhq1IskumdM5BFh47l2UOhOW9DAUUMQ8IpooLtNynqxu/XEng05gfy1VidwBxvDaYBm/1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6707
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Pavel,

Hope everything is well.

I wonder if you have missed my last email? Is it OK for me to add your
reviewed-by tag to this patch?

Thanks.

On Mon, Jan 09, 2023 at 04:05:52PM +0800, Aaron Lu wrote:
> Hi Pavel,
> 
> On Sat, Jan 07, 2023 at 10:50:44AM +0200, Pavel Boldin wrote:
> > On Sat, Jan 07, 2023 at 10:18, Greg KH <gregkh@linuxfoundation.org>:
> > >
> > > On Fri, Jan 06, 2023 at 09:00:21AM +0800, Aaron Lu wrote:
> > > > If you do not trust what I've done is what I've claimed, now the
> > > > original author Pavel Boldin has given the patch a "LGTM" tag, does that
> > > > address your concern?
> > >
> > > I don't see that anywhere on lore.kernel.org, have a link to it?
> > 
> > LGTM.
> 
> Thanks for the review.
> 
> In Linux kernel community, reviewer normally gives a Reviewed-by tag
> when they think the patch "LGTM". And in this case, it would be a tag
> like this:
> 
> Reviewed-by: Pavel Boldin <boldin.pavel@gmail.com>
> 
> May I translate your "LGTM" tag to the above Reviewed-by tag?
> 
> BTW, the kernel community's explanation of Reviewed-by tag is here in
> case you want to take a look:
> https://docs.kernel.org/process/submitting-patches.html#reviewer-s-statement-of-oversight
> 
> Thanks,
> Aaron
