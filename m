Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CC3671319
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 06:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjARFW3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 00:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjARFW1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 00:22:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF0C4FAFC;
        Tue, 17 Jan 2023 21:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674019346; x=1705555346;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MhZbQB/nyLhLLO7qbxetG9e8LNxKApfIAEAyYaRMSG8=;
  b=cEUuYEdte+cVgqRVjkbpoe2vwOvUSxgyl/owb2MlEVW/Jq30i/F9Ddh3
   wpA0y35RufoBIwFGJrcB9nr5cyVMBa2NZONEtuoAxUlL0LQtLsy44iN4p
   A20MXRxGXDPtqtN4UkvwuhuaHaE1Puqvn4MtYSMrXESai59k7TEnub8zI
   iShYeUtrpD0nz5sQau76XdMqhVWP6n/hng2uFvOAeFUn+7Ezma5Nz1aQg
   /ss9zbwR2MwzcIqEtodhjhEvSQVt2Bi6YXIpKFbJxvdhWaEeL98I4O8x5
   ihYVpHd8JkYuNZ1rIPuyDVGnhQ6wfzIUBj8ulxR5MSrnlk28ZIQBPS55x
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="322590921"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="322590921"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 21:22:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="904922895"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="904922895"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2023 21:22:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 21:22:25 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 21:22:25 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 21:22:25 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 21:22:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDEd8Gqrm3TXZYrKX0bUfFsayJglBebt2ApdoIff9s4sssnCzQqrX2R7HsJtprRpvd4yaGRo3gqhMsNg8bcRyJV1VNxR36H8R2mOnoKYfL/2qyjO5mNgF8QtgMjCPiFUl+jz6uj/g6Qq0Ensoi+jRj1nYLbWBO9MtudYdSXPZAm4rs4Rg8yZwAuyKjQB8e9Cb1Lh735D0X4pRDoYq2R6aljwYEADCweaJYgIZbz1aHp5USMpGf+fs6gxlT2QZb6X2Hd9oKuOtezoGlJ+y0hbFRV/9yjPSSDn1j4A4etSjP25mOrWLUYQOU2hVyICkxUylym6npd+9vDubyTtVlwBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI55FNPlHOSWHo1TdQwcrY9En0P8UYevM0Zgc0li5N0=;
 b=jWztxVguvXQx92FbL2Z0cvPIpFzzQlAhLG+3YdqHSj+RyRjqE6VLK1h2wu8kyVvu+WVnB1Dx/1oiB1qPv4ypigpucn0mIWgoHuexdJ9TXwJ3Bc2MQ3Tz8h0KGA5z+ptPTm9HekhF4KwajbHepvt+PP3+fInIqJbBr00IJAelzWtnz1hPMJ26PmfMueFrz/KHTysKkuTTy4L7OgBg1qCL2pd4CPmiiO8ntuH8EA2TSWgFSAnxC5VwVFBv7R7epQQiyV8kSniKQ3sTcNeKOipOYs4PcrZMtNauiQARXXHZ2jau+grpmLCRfO1Z5Ni3J2YK9Aus5+KGoZboty9iKhBWxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH8PR11MB6707.namprd11.prod.outlook.com (2603:10b6:510:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 05:22:22 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::e478:cda7:b9c4:c457]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::e478:cda7:b9c4:c457%5]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 05:22:21 +0000
Date:   Wed, 18 Jan 2023 13:22:11 +0800
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
Message-ID: <Y8eCA7hdde07a4gz@ziqianlu-desk2>
References: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1>
 <Y7bT0OL8RAWkCu0Z@kroah.com>
 <CAKhLTr1a+fTs2KyT3fm9yMxfjNwW_yLV7vRjrUXdNx8gfg8LqA@mail.gmail.com>
 <Y7bg5sxEZDIaGoXK@kroah.com>
 <Y7dypc4sFcmYlXQQ@ziqianlu-desk2>
 <Y7kqx5cBCVojq6QJ@kroah.com>
 <Y7vEg/VHWsp86B6r@ziqianlu-desk2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y7vEg/VHWsp86B6r@ziqianlu-desk2>
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH8PR11MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2b1ac7-6735-444c-d95e-08daf913f9c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aG+Kc4B7Uez8e/i4L4lnpvaenIkN6/v/Xcy60v+cBXnzTAQgB9RdxXeIC8TwGTIuTqPcqrcUIQSEjYm4uGIJavfbEYWpAI5gTBVp7PWEn0xb4C4SCMwo+Nf932NF/Cna61FOk2T5NfAcQf+8wrHnsJFfJvQrkCCIOJTImi7Lt3InaQnhfQJzGt0ybyF20l85aMj2enkWGAenkEJmBwIdstgoTfdeasQbEdcMfzCDpSgnXaiFbSP/rwpDws1zeG+gzNoOOtqvzI30juvdSMNEUIOFxOsb8jUWEbvZzFobRVyzadUtq0pUgPSVlbwb/qzXBYR605UbeuEhOKvH9F/khg/yzft+Oi1dcnRwX5WTRISTy6pPapHBeEZSXD/+JUkFx0aXgoau9bTMXBrZC2CEzPI9QdOM8kbJhR3MwPQ3lIubrFifIxMpd0og+UITbLnNg3+6BTCCjIDLb+0ydQBiEqczfmuDCEjlp3iQM+BWY3+X/SZaXErWjpOvTmhWIvtsbqoA9sx805fxQWGL1yhdOrvbZKEpxUT8n5vnWgBgI0eExvpol5Y7UQJ3VQU22Ay8SOrmsNre0Tm5IwZIue0yarInGzSClcOmKxeNWsRy1X2TRoAwxIRAsPNpyz+xJCPC7d1gZ0/ycmawebJLJ3k9Gl8+cI7YteenbHXc9Bswzvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199015)(4744005)(86362001)(4326008)(6916009)(8936002)(8676002)(66476007)(66556008)(66946007)(5660300002)(2906002)(44832011)(38100700002)(82960400001)(6666004)(478600001)(966005)(6486002)(316002)(54906003)(33716001)(41300700001)(9686003)(26005)(6512007)(186003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DKunBzEDVr9jTO0V8Jcc+3FWfgHgxN7SrLwW3fgIIWLYv3XoewPWA+4Vdj0m?=
 =?us-ascii?Q?gaBvX///z1Z7Qi4NlhnkU9t+ARRaMSw6uztK0aHMQnYembwgduImjm23vSgw?=
 =?us-ascii?Q?fwVG6+6Cl4rjNXeRmpe5CzFhLUbLLhM2TtAey63R1KWM7SvAFJqrwONu9Zc4?=
 =?us-ascii?Q?CgMeEKxeHPGu2TRXrjK7p0Uye9rM5j60ZnMjxfNCXUgIXRLgEARbzmbb7sIn?=
 =?us-ascii?Q?jc8ixKeypwaNLdgRHUNf3CsvSwBCDQe3W8dUJEA0ZwJaN5dLhijAKQGktqqB?=
 =?us-ascii?Q?iczotQ35no2Gzxf83eG9x6M6PSHwGuHcOlC7caB2wwF+4RF+JBuELM8N+RGt?=
 =?us-ascii?Q?ExaXoDZoeljoWFrHoByt17x2YLrgKg6ex0oDKSVrkY8YBy21dj29Ffl0z+ES?=
 =?us-ascii?Q?XLjvaUzhb+1W1aoHDgRNFpt7Ex5V3JJSHrKPyS0dtSHa9wiga8ibQOlqP52M?=
 =?us-ascii?Q?JmIFW2PiHSwstsQzXJL8peiChTvLw4WBzMtpPci3ubHZzzO9eLFRm8TeTeJk?=
 =?us-ascii?Q?EZv93TmJHGR7wrW2IZlFvmI8+vT07XbhYtEYw4IogmO9x3pTswOy7GsTrR4v?=
 =?us-ascii?Q?acxtbujhl5xeOlga1xzgUcAHa5JXKVt5G/nBLhZKP6ByuiZtBRW4PfThQK9v?=
 =?us-ascii?Q?MMnqaKnQTmbasbE5aOtfyVzSq8na7fny4I6Jfzmj1d2SPo68xDS7A9Zn2jIo?=
 =?us-ascii?Q?Ty+hvypN0FDoidz7snW93H/cDiAPfiwPk64YyB3aTZ39n5vNLpYXw4oQW9Nh?=
 =?us-ascii?Q?aaynYibqyxqk4PPC3f4nUDZJgAquTuJqU+8WgHXRMfJ31bBZ0/Rdvy31cu5F?=
 =?us-ascii?Q?OAeXeO0OmMCUv6aNySnpEHsznbZB1HPHodrm8A0GHF1rDBet1ZnD6mOSYTfc?=
 =?us-ascii?Q?sgJJZHd9Jcy7i0Tir3G0lOJK70d3RJBQ+F2Fsg6SvrGYD5YTp/Wlrx4Kv8qQ?=
 =?us-ascii?Q?UxdKXCuXyr+oH3w9wRouKqsWbOgGD13RBg9+G2AKKTSBVN/WAaGUfZLUkXaB?=
 =?us-ascii?Q?ekaGFNIgSfXKXYZ+7t8hAMMsHUWAl63Ek/mG58F9aHXWzbguyiQJqbw9AfSD?=
 =?us-ascii?Q?mKWtvh8YubhnRPIjrgDN/d+Mh4Y2TlZDSqZxoDI7ewQ1Aph0CZJ+H4ugd3E/?=
 =?us-ascii?Q?j3y/OXnn1HAmbAIhVCcongKgicGB+9WiSBGzr6lyRZVU2JLCMZcOFkr8E0pQ?=
 =?us-ascii?Q?otaLcCLr9KzjFEQ0p5N/RmWuNMKcN4DIwoU/RgCi8a05/v1p1+xXOQ23gvO+?=
 =?us-ascii?Q?AwpzBWcGjzY5KdOeIwmBaE81o0lB8dehncVWSRAICGOGCsnLBIvNuv+iQMye?=
 =?us-ascii?Q?iBvmA57eSpG7jFkbMijUCfY1RISPFWc18kdOpjabE0TBv65//mZdh2MDeQup?=
 =?us-ascii?Q?o62QOYQIfj66ZDlj4DdJb9/DOYpdAP7F01CZd7ZDAro4z3PGo/mRje2jm/JF?=
 =?us-ascii?Q?7Iub3VTnIsjNROO0hte7DfTV+V9Z5MbTf9vTt8TLMu/Z9pHTYVRe1RN3N1GM?=
 =?us-ascii?Q?/eGLSdFSI93IZxbj7xEgyXSTgdQKNwwQeMTwQs28ixJKcEzOcfgHlFf+12rB?=
 =?us-ascii?Q?QYdKO7Qa1ATA8ecw3xbHxnMrUgKgtQw+vJxscFt1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2b1ac7-6735-444c-d95e-08daf913f9c1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 05:22:21.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhB/t1qSR9juo0ByeIJptchafEDmLUph+UO/yVhAtUCFshF0m51BNE7ZiNs4TvFNL2TkLRS/W/Qib0/VMdGIPg==
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

Hi Greg,

On Mon, Jan 09, 2023 at 03:38:43PM +0800, Aaron Lu wrote:
> On Sat, Jan 07, 2023 at 09:18:15AM +0100, Greg KH wrote:
> > On Fri, Jan 06, 2023 at 09:00:21AM +0800, Aaron Lu wrote:
> > > If you do not trust what I've done is what I've claimed, now the
> > > original author Pavel Boldin has given the patch a "LGTM" tag, does that
> > > address your concern?
> > 
> > I don't see that anywhere on lore.kernel.org, have a link to it?
> 
> It appears Pavel Boldin's last reply didn't make it to lore for some
> reason but I saw him kindly replying again and I suppose you should
> have received it.
> 
> But just in case, the link for Pavel's new reply is here:
> https://lore.kernel.org/lkml/CABohvEPWBHmrRpZcQejTkZ+CYtYCyu6rFMd4doNn_CMk35um+g@mail.gmail.com/

Now with the original author Pavel Boldin's "LGTM", do you think this
patch is OK to you or you still insist something else? Please kindly
let me know, thanks.
