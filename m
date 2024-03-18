Return-Path: <linux-kselftest+bounces-6406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35CF87F332
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 23:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44C91C20F51
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 22:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED25A5A4E2;
	Mon, 18 Mar 2024 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLn41w1J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE86B5A102;
	Mon, 18 Mar 2024 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710801815; cv=fail; b=JuSAo7dpO9sDjY9kNF6BOFWOMr6A7cQzOEYpRM2GflHaPoRHkhoSbCyeJ57bj1qQClYekc1B5cHCOzzvEb8ExR9QLHrETw36L3c8K41H9qDPENDva8jiaK2re0LdbUl8a9K4CR6P5sQt7X0iTUEjYYWK67vDBeHMnFRfTkInXPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710801815; c=relaxed/simple;
	bh=KYrwF11uJEGzXPWnLHF8nt/2HLDntD0cPzyhwMxNfws=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lkr8d8osw7fHAu2162LcqZlhyAiQKjoQ6kWoi/2UaqIa5YLnkOvJr1qOtMm8k5be7hTCBztI6eFQJWwnQ9OKFwnliL2l6TjSPlE3PyK8dWPQRoyMjtQPmBxFEzbejW6cu+08RFVZt9qja5OdgeSFFqKAMCEyib4rx62Qs9J7A0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLn41w1J; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710801815; x=1742337815;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KYrwF11uJEGzXPWnLHF8nt/2HLDntD0cPzyhwMxNfws=;
  b=HLn41w1JhCVcAdfs1clVmV7uxkT4xkhyKXv3u0VOLoJ65psSok4rEn9E
   SSoL2vCgEik/lJLaAagUmlsmEYpUt8iQvlf52ZstHOgpN+5GmkoTxS/PF
   69I3nXUdawhKSSW8kcvkLDXbEnq/OaoVzL6Njp6JHFlxu9Uq+TxK+Unh8
   noA4A1Ocjgpiv2SE739YdyDPW0t7nssnbGm3dtCYh01T0Hm3Yvx8vUq7a
   0IadLxtTAGj937IwzIFNEUdahk0hd+6Fe/MCOsjP7WYhomnY4HK83Wb8f
   mRIbRJs89baaoUy98AjI4Yu8LNo4A4SB1eidhCsLf0Idiq7UQhbSQhgaT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5770846"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5770846"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 15:43:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13570847"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 15:43:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 15:43:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 15:43:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 15:43:32 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 15:43:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7IKczithTIoZ5IiKhX95xEEplGHDxLNQXGxW0q8WcbtExXZbbhMC/3M+sc8q4OJ3Z81veHzzYxQnT5/JeyNcik8pxlfXHaECcBpAl/+Isy93vPHM+VfiEl4DWQbXFAI9P7PE7WfHsC+Y57YBHlmHHpWBUTwba+TYwpvjAN3pES+8ast01j2v1boFxvtA6y6yfGsgr1TunD1CsFr+08YjQEUfpWKOLqk3bUFFHY+Ev2c2axwQ16fPBXPWUjntwVGL2/LQ4iXOjGQ9rCzf2qSgFRBFQwZLwGrQeJuZ1OwaAA3jsyzqp/a5HIBChbepq6yy200oPpGDcBMoZV861sdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbPfvYwg8qsf5JjSmS6zQN6NU0ac7F1OJvmgfkbGvw4=;
 b=WGwVXUm3HmGwIbGnS8mQWYKN4jA8n2IyNSytPcok0QZPVAfw809PDOoGatBNgM09KX1pbD7GjXh2kHRp7wz+K/8lXq17t9jzVi7Q3XCZKk2XjnTDw0Zyp00yAAjy+bWE5itYMrEXxKd4nQ6BuIElwdxPsbrJEJDi2muJKqjxzCW3bEKneNR3VEoU6fabPtxZOn5qWVHriC/P79rkE/TmnpvUNe4aysO56wUO0lMuqxwijjLj+k1HEiqxlte6Jd33MneQf4bCD2oPbHFPgmg2MfWmMZ32TlKJIuQETKiCLmOlbPhaM8254t1eU+OfJJjCZ9MIGF3MEc/2ROBI7TupEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7745.namprd11.prod.outlook.com (2603:10b6:930:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Mon, 18 Mar
 2024 22:43:30 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.009; Mon, 18 Mar 2024
 22:43:30 +0000
Message-ID: <7f15a700-f23a-48f9-b335-13ea1735ad84@intel.com>
Date: Mon, 18 Mar 2024 15:43:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, James Morse <james.morse@arm.com>
CC: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com>
 <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <55a55960-8bb1-4ce2-a2c7-68e167da8bcc@intel.com>
 <ZepK4mtoV_J8-UbE@agluck-desk3>
 <eacdc287-24bd-4137-85c8-df055cfd78b1@arm.com>
 <ZetcM9GO2PH6SC0j@agluck-desk3>
 <88430722-67b3-4f7d-8db2-95ee52b6f0b0@arm.com>
 <47c28b3d-3b90-4b33-ba71-1e359d43238e@intel.com>
 <SJ1PR11MB60832422CBDCCDA580010769FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <6948784d-6a20-435a-8781-30f324bed472@intel.com>
 <SJ1PR11MB608303C5E0BEB42CAC5B02BAFC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB6083FAA69AF7F712B34CA292FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <176e6031-c95f-4c75-9857-5f8fe6c4e67a@intel.com>
 <SJ1PR11MB608309F47C00F964E16205D6FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB608309F47C00F964E16205D6FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:302:1::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7745:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzUx1/qllXuMBvGIWKhqm/QbfGZ1VC+AgUDpOF0vZpAWHwu7Q3vJUHqwBk2dDDPOJHFHfVKZdu+FE8seC6magG5FYFB+Fmcg9+gmx1Xo2XPYn3SsAJr5TSLe76uwPrmxGwGHlw4bTGGXcxX/D77Uhc7iKy2vpfm3xYGqokEz92dMOfQTRqyWtuqviXwP+sRpqm5lmgLtahr8Uw6GrgPLwC2akfV8Fd1u6GjtEv4kr9SfYEYjvILLfDOEal4wvC7frWHi5wqZvza/svPRr5V6JyQXfLOqXYdgzVgJv80xrXHcl4b4SsZQzJ0zWIozRxSLYQdV+WbMtJgbEly8wilHZPjsdEknzFDVwIRAZbo/ky8vlJrNDl8ZWVIP7gJB1Nl7Zws4jae8jbtWFnmAsn+G6XvqexbMeYB3IuLOKbm37cXiTK2992jiL26c/GeMp1sq6HoHK41Aeiu0HY6NGUpR8CJ3P6W+EKvnXkLIcd/uMA+A6CPl3/BhL6w3QmSGXy7+5o2SEyCg3onWi/77fBM+tBvxbXuhMhkYQ94hdsCjmv6i2Y43U3ZbQszxQ/3RaET0XB7f3opGcfwF7hyhx5mVyYsXL+TzeE2QxKbqP5lBA0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzF4M3dseU9hTStzN0dTZEZZc2cyN1g1aUd1U2t6NE1qUG5uUy9mdHgwWThV?=
 =?utf-8?B?Q1J5YlJUYkdXOFVxUE9tM3JvcXg0VGxmV2xoUWlCQmYyVU1lQmxiWnRYZ0lh?=
 =?utf-8?B?ZDRldzdBUFpzWVExYVJKM040eG5QcUl6TTV5K1BpL0NUSHlHdEJRR2pGK0JO?=
 =?utf-8?B?SFV6Q0RJZ0lYV09UeUdIWk5vWE1RcEtuY29oK3pNTTdudlg1Mi9EY3JXL0p6?=
 =?utf-8?B?MlducGVCS21HUkh1SVNhUUxYR1kwcXhtNlptdnMvNCtFTDI1T21XQStvZllp?=
 =?utf-8?B?TDFma1VSTWJxc00xWXQ2blJhbkpsTmNUa0orYkdsbWZSU1N4MUw4cHA4dFc1?=
 =?utf-8?B?cnJYNlNtVktxdE9BYzViYVU2MkVwSEVmVjBKYjhBRlpQVFBOVTFEZVl0MWFW?=
 =?utf-8?B?ZHZjUC9FQlpvUDNaOFVYN3hXT3MwUkVzMlZEMlhNOUFkM21vWmJGK3RjVVJS?=
 =?utf-8?B?Z2VqUTlJUi9pREg3WHUza2FBdGF6U2k5N3U4TXdDQkJsTDBTZnY1c2hDNk9C?=
 =?utf-8?B?emJuQVRrT3o2UDdYVFVvdGRicUZzTlllVDBTODAyWnRWRkVMWmkra0J6TVUy?=
 =?utf-8?B?ZEtxREpzMFVxV1lBdnppQ3FTcyt2ajFnWVBRMExXcW5yOU1VNGNSRWpQeEhV?=
 =?utf-8?B?SEptak5mN2tMaHRCSTYyQXpPOXQ3SXp1d0xhNFFMRm5TcXRxY2w2R3NmRFl2?=
 =?utf-8?B?WXFsZWFtbFpOdHhyME55Y0FuLy9WNU5HMXVzRGFXZnFRc1pHekVJOWxSTmxa?=
 =?utf-8?B?bU41aGRJZC9EQWE0TkgrYTVFb2ZTYlppZ2N6WWE1L3ZyZm5ZTFEwa2lsQm1W?=
 =?utf-8?B?NERzL1p2d01HMHMvOGlPdHhoZUc2SFN4ZzdEQWpLWjUwbEtCS0ZEZmxuMStt?=
 =?utf-8?B?M2pWZHdpNUFsL3ZFeU5EN3BZM0lxeFR4ZXpIU2Zzc1BQbzVBdUl0NTZiSlVo?=
 =?utf-8?B?Qm1OTXlSeVpJWUxhOG55ZTlLY1NnZlJ5Q2sxMXRQSkdld0c0NHZwVE1nRkdU?=
 =?utf-8?B?ckJRQnRiRVJZYmpBZWxieDhBUmMvMnlmNmpjbkZiRStXbzBDVUxXVGc4QjBy?=
 =?utf-8?B?Y3pIWEZjN214ZTY5ZWdSbDlSTFMxbjF0b0JHMWRvcFJEMzdBY0NvNWlrMTlF?=
 =?utf-8?B?Ry9VTVpwWmg2SXU1L1R0VW9xQXJzaWhxbFdKeVRhOWpGWlNIS2ZQVThqV0RG?=
 =?utf-8?B?VVp4WXFwZFRwR1BCWlhOd0dGWVEyZjAzWVVpaFBiMUpOV0ZyNXpqTGJtaXBO?=
 =?utf-8?B?ZzJ0MHU0V2dlMUxUejBabHRmRC9JSWJ3V2dtWVF6YVFVa2RmYW5tTm1OTFNl?=
 =?utf-8?B?d05HS0tCNlF4cUt2cTJMR1dIcHMrZ2FTU3V3NU1pZU03Yi9SbndLQURySFZv?=
 =?utf-8?B?STV0SytoUjBFaWRJZFBrVkUzbkovaUs5VDFFTkhyd09jOEx3dllzdlVkZUJF?=
 =?utf-8?B?Y0o1RFpmMFM3MlA1dFdOM0NpQ1pvb0k3YVNNNVRuYSswMnV0b2lBOS91QXhy?=
 =?utf-8?B?UTJRekV0RGhGdHVCaDBPRmpzTG1lV0s4ZUJEQ0JoQ3BRV2JLQUQvK3hNdmNt?=
 =?utf-8?B?WUZMeFZ0Z0VlZHBiODM3ZEdXV0VycGFNZnpFVW9XOUMxeDYra0xoS1E0bnZV?=
 =?utf-8?B?M1gvajNMak9oS1pOVGQzTy9YQ3Z5c3hiaE91ZytZd1I3c2pWcDc4andzODlI?=
 =?utf-8?B?MENobElWUzJmQlVsb0p5SnhpUlhMaGFhblY0OGQ3Ukd3QkJkUDZYM05LeUJZ?=
 =?utf-8?B?RlhYaUFIVlpJU1J5MVlXcUcvMllOaWNLaTM5UE1qRXdBeU5CNjQ2RThuaGtu?=
 =?utf-8?B?ZExwMmlOQkhXbE41aXl1eXE2cTJvTFJFZmxaYmFvWnNhd0tlcU9DQ2dCVzhW?=
 =?utf-8?B?S3NzNERmSVY3OTBURmR6cGV0SDJVTFdXaGxGVmJYNnczaDhzd2xLNlJJRVd4?=
 =?utf-8?B?RUxsNlpFTWVlV2lRcTY1Y2VIeXRLclNqUmlReDNIcW5mTEQ3OE9WaXhWZ1Zm?=
 =?utf-8?B?WElWL2wvREdhaGdlbHMwMjZrcE5YditSSEV4N2Ixb1YvbXprQld1cXpqUEVn?=
 =?utf-8?B?bnc1ckFiVFUxYTJXY0xNVVpGSUQrSGgzRUpiSHhIdnJzQ1BvdWhMMStDSzFQ?=
 =?utf-8?B?ZzgxVllRdXVXcU1sNjRoU0h0eXg4NmVwZ0wvVnByUVdxdnBSOCtUZkxvV0J1?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aee8b4e-13c3-4222-ee11-08dc479cd558
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 22:43:30.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48m+tMt+NukLjuTycdyHX/86SxuT7N7rDMsQWThjLejkDYBFlccxWrynuwINo2phxMLZ3/aw8iyD75cHE7WdfSZ3k2jXxz4cveWu6v1oKSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7745
X-OriginatorOrg: intel.com

Hi Tony,

On 3/18/2024 3:00 PM, Luck, Tony wrote:
>> Perhaps ... in this case it may make things easier to understand if
>> those "mon_NODE_*" directories are sub-directories of the appropriate
>> "mon_L3_*" directories. 
> 
> Reinette,
> 
> Like this?
> 
> $ tree mon_data/
> mon_data/
> ├── mon_L3_00
> │   ├── llc_occupancy
> │   ├── mbm_local_bytes
> │   ├── mbm_total_bytes
> │   ├── mon_NODE_00
> │   │   ├── llc_occupancy
> │   │   ├── mbm_local_bytes
> │   │   └── mbm_total_bytes
> │   └── mon_NODE_01
> │       ├── llc_occupancy
> │       ├── mbm_local_bytes
> │       └── mbm_total_bytes
> └── mon_L3_01
>     ├── llc_occupancy
>     ├── mbm_local_bytes
>     ├── mbm_total_bytes
>     ├── mon_NODE_02
>     │   ├── llc_occupancy
>     │   ├── mbm_local_bytes
>     │   └── mbm_total_bytes
>     └── mon_NODE_03
>         ├── llc_occupancy
>         ├── mbm_local_bytes
>         └── mbm_total_bytes
> 

Yes.

Pro:
* This is familiar to users when compared to existing
  CTRL_MON group counts that are the sum of the MON groups within it.

* Users continue to see the clear connection between files listed in
  /sys/fs/resctrl/info/L3_MON/mon_features found in "mon_L3*" directories.

* If I understand correctly it also would continue to be useful to
  Arm [1] while not breaking existing user space since the
  mon_L3* counts continue to reflect the entire L3 resource.

* This addresses your comment of maintaining the detailed information
  from each SNC node.

* I do assume that if there is only one SNC node per L3 cache then those
  mon_NODE_* directories will not be present and, to address the issue
  that triggered this thread, user space can use presence of
  multiple "mon_NODE_*" directories per cache instance to know if
  SNC is enabled.

Con:
* Unclear how this may need to change if/when SNC becomes architectural.

* Continues to "muddy" the naming of the directories: mon_<resource>_<id>
  vs mon_<scope>_<id>. This cannot be turned into agreement with user space
  where first directory is mon_<resource>_<id> and second directory is
  mon_<scope>_<id> because then we would need to have, for example,
  mon_L3_00/mon_L3_00 where the first directory is for the resource and the
  second is for the scope, which appears redundant.

* Things may get confusing if there is ever a "node" resource.

This is starting to look like an interface that "checks" all the
requirements I've seen so far. Looking at the "con" it is difficult for me
to see how doing something like this now may cause frustrations later.

Reinette

[1] https://lore.kernel.org/lkml/88430722-67b3-4f7d-8db2-95ee52b6f0b0@arm.com/

