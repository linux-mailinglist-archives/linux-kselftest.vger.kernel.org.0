Return-Path: <linux-kselftest+bounces-3545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275F683BA75
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 08:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E92A1F23709
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 07:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458E6111B9;
	Thu, 25 Jan 2024 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y03opkjX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76710976;
	Thu, 25 Jan 2024 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706166792; cv=fail; b=JAFvD8jqhowGcCPdZHFKZhr4ToMv0L660ODYy5TDUxIRGVXLocsCuPCOwe9ufbttMllEnqlcdcqcDfMR0FvjIThVKljrDCctKDLSxBTlO9XqFkM02Xj6Tr0jR6iuTWm1Hodnr0urUp4ZlN2V5nIjYVAb8pMH+fL5FT9sRgqal04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706166792; c=relaxed/simple;
	bh=smS44LHoSlkXoiE1uJS8jRHSpwOB8Tancd5Ui2FxP1E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=skEc84IpIZ9kkZBEfWYw4RDwrJtRn4VeQqE6Xctw2Tly8yljnyQl0gJOexmE5zXl5ntiMFfGBXb10AAExgOXcGQwGaKoJPTkOnPFTMBIbzXfSShlR5dVP+McDsatQGg0ilv01O3aoj80aRgAe6D6NBL1l9FKOAeZevtEYWXRRPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y03opkjX; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706166790; x=1737702790;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=smS44LHoSlkXoiE1uJS8jRHSpwOB8Tancd5Ui2FxP1E=;
  b=Y03opkjXzU6PebQu2TSyx7NhE5DT1HGFU1RvomJdjGQLPZEa/QhPg5Wh
   zRBo1S5DhIslarPIBXfinod2nI8gr12Qmx6c0D4zoiID0V4LOZgxo4+e/
   4GLZtt//sq2Q4yn2+AFbRpEFSLm+T5PlbCcFH8N2ZbDteJ0LidqnGDE3B
   /ookUez03ONYg3zChn4S5QVP0KE3Dzx3sQS9M4ACSb2Cpq+fE+iZ/WcgN
   q3Sca7bJe5WKLBr0GMB3fUE6BSq8FQEy8p4JspHbODe3lb0QQrsbbynh1
   fAtYxCjk3RMF7aUKNCkHajVl5VVNQ7lgRo++DaZApM6oycyjLU2q9PqNT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1924915"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1924915"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:13:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2182631"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 23:13:08 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 23:13:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 23:13:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 23:13:08 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 23:13:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1uWv+VsJ7EU1JoNLGG4qxnORMbdugJkXf5+O5twBZMw9+RWKrBEOgwzAVf2Ln7ve3/+DG6f8tqak6a17DAqfRVO9spvO6+YP0JTVQon8Z4EExgfN54YWWoqJh7tDo+3g09s/hHq1qgWQSJmnSAuQDoUB8WmOcp3OivOSGFy73a8ohP65eZz5arZzSla2Ik+BW1BCgjUkFojcV/HzGDiGWW226iB6eJI2q3pl33YKJQuZQQgqhQKCAWs6MdcJK1JvN0IEfdwJL0pOEqGnKHImb20MgMv9DDIGgks5b7Zdb+00ECNvP6GuUC40tubODze14sQMPtzFLxJteb7cEYIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFqXuvYlLfjh2t7lZKsZ0Ze2irA5mnQqZQIcwvdk0QA=;
 b=Xk5r5D6F/VYOIyk9HC6iGSBUx6p9Fo34yVU6V9imXc5K/Mmvu7rTqLfW6WOTkkl66oyamqWfOZEG6ysw33iKEDmL+qXFOlhhgSmtU+Wwojqa/ohjQOLSbtOqNE4cdIdro58K3gp54Lr8RubaCBqumsdN3p5P7/uYpWfEsdyM90o1zutXrjxtl29f2dwZB09L0H4cvA1gtW90Ik7or++N58fUQGpn6C4z9z7WsF540IqHjJ0Bw1nYm1gDxpwGjKcuBZPyrvG+rL4gJLrm4eFAjTjD09mylgxNdZ5jMdkOby0ECg+7YZ7iK95OpMlasPLUVJT1hDukBIS+nTXJqhjesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DS7PR11MB7905.namprd11.prod.outlook.com (2603:10b6:8:ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 07:13:00 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7159.013; Thu, 25 Jan 2024
 07:13:00 +0000
Date: Thu, 25 Jan 2024 08:12:52 +0100
From: Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Message-ID: <jkpv2zrgtudixtah3d7byy7lk5gcngdprae764xxregkbx3lil@xximqpsphax3>
References: <6v4hgra7bd5nwubcgtbsidmoohrgxdw7no4faa4a54g4vrxo63@c6qnujvwn5ej>
 <73cea732-3757-4aec-a39c-4f0e50f6fb70@intel.com>
 <su2d6i22icynusoykmowfnzery6hlqugovaw4xcrhb7r3ymbx2@aeimvrxsc5xw>
 <05db3bdc-9d54-44d2-8aae-07d66053892e@intel.com>
 <wvehk3j2dcf3lkuantb7shefymxj2mnzv4pgbiqbk4jkmmzeid@lurk3dam5tb6>
 <92bccaea-b73f-42e0-a386-1a73eb6f88de@intel.com>
 <m3bhu3j3jzdo67mmuezjmwu4elyqjdwmoixcxm7qthls5tueqk@h7bvwxmy3l4y>
 <227e43a1-a11a-4d49-8dde-c8b65527e926@intel.com>
 <h7cbw6x7bxx5o7vyamhacgarx5fs5rgmyttawxkrl6fgtjjqmk@naisceux4lns>
 <1dd1c812-ecbb-4972-88a8-4ec7dd82ba8a@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1dd1c812-ecbb-4972-88a8-4ec7dd82ba8a@intel.com>
X-ClientProxiedBy: VI1PR07CA0221.eurprd07.prod.outlook.com
 (2603:10a6:802:58::24) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DS7PR11MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5781f1-c564-4b54-c4f5-08dc1d75103d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18c2Z98WCZifk2SCWok5r1Eg3D56NRc2oMgChMEad5QXUz3aRtPFeiKFWAs1w8RIK8MEz2aHw4j+COTLtc5LBjx+BQVTTanIqJ30OFBlkl/OziWI+SsKAZ+9DA3ETSRLzzK536TtbyYX6+iYp7cGVGN3YM2Zu0/LXyLYL5b0EO1EbSbqiGkaRIiQQ58u7/6faNV4IFvPLK1cqzfh0xslGN1pYS+uVZXYPdXNjt1mc3LAGhZg7Df/yMtFp5PIyubr7gn5Xz3fn3upnZ3qIHNEu71X5Kx00CsaH1kt2VDkCrkWRGG8E6yN3XsGjoS26QLVj609g3STApQnz1NQMgXDLhnf+E7MVUDHH/JQQxwUug//c/WijTdZdRK+uKAn1IK/afgNxVuyld30tdikxwHbPA/YhH7SRSVYwQWUIqQpj0sB24IriJ6BtMX3BemAVBKeK9A2i+0qS9BOaiP0hL9rx01z0MlRyOaMSXETstru0c+x7XojmQByri2KbQOa8mU4RsfM0Rn6fc0OCycMFFxaVFNIFthAvoNH3FMFwWPIX63w9ISmFMtxMlP3oZNUHfGc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(2906002)(82960400001)(6862004)(4326008)(5660300002)(66574015)(33716001)(8676002)(41300700001)(38100700002)(54906003)(6506007)(66556008)(66946007)(6636002)(66476007)(316002)(53546011)(478600001)(6486002)(86362001)(6666004)(9686003)(6512007)(26005)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?PTAXYfseAxAs1Ubpr8N1ZCE+2+vMLR6QH1+WZryagQwJoohABdynWjKgEv?=
 =?iso-8859-1?Q?Rw3B10HTckDVjW4vjvLJjLg7EvfBSZux4dgPNb2r1B11e3fy5yDaNVVD5o?=
 =?iso-8859-1?Q?T1EZ+mJImBD+WZncDOCFsdVrhF0YwuSW1fcaRhypMolwSKspWRBa6Ve5Fw?=
 =?iso-8859-1?Q?KQ0UFozxFXt4aOq7Ayjhfb3tb737bao6rNBWFwUqyD4gJoshKugc/KvnS3?=
 =?iso-8859-1?Q?nnw5QSbUVHg/HW3jR+czHLhommQ77LbzRWABa/8drdZB1hsuX2vWD6hU6b?=
 =?iso-8859-1?Q?BSMr0fcHOy1eVFpZQthYcIFDl8e8NnAmcP3BRd44lXIVxh8pFoOXiLstDv?=
 =?iso-8859-1?Q?B+IXjIqSdSQIA0z/a1Q+FicygDqctoYMF+l56GG7MC8pnB2/lh6M/ZXn39?=
 =?iso-8859-1?Q?jHsJaqRbP6p6+Nm9Gr+n1FpXV8Ykd4k005BAw9i3+enFiHzs/0uipIDksq?=
 =?iso-8859-1?Q?cD1UK+lWOdz4dHGQZfRZ3H0S2P0dBGWfnizf13F80q4C4G74+diRlE+g8T?=
 =?iso-8859-1?Q?CXFKGz6WCm1Nr6LjLuHpM/Jr6Ww3PyLmRNXeukNNG+K79P8lqlvSg7Zrlt?=
 =?iso-8859-1?Q?5HD1fK3p8MNYqxjpoT0bBPPvTamaJu6X1Mx2XwQHsmuBdsqvGlajE0yNjG?=
 =?iso-8859-1?Q?roWqlhyHrNXwOME/kzScl1G5nMGGwJSTBsa/4zDEPFGV46PikfXPvGl3xo?=
 =?iso-8859-1?Q?17cG95YDYxArBksddTDyhVCPROqSiXXh0cO3nPcu7SNDpfH8cX2iMpTtzP?=
 =?iso-8859-1?Q?lBMFvphCmKPm8/tqc8suwBGjwVqrKztkcv1u2NEyTkATL8abdAl8SvWIAT?=
 =?iso-8859-1?Q?CmxPubJz8FiQjr3Xy+0axNS0r0FqsnL/JMexsWdwixnNSsKMJ77hC6KFei?=
 =?iso-8859-1?Q?ZukGARHS7nGpzAsZbm5P0LnZT4bhCj+4OWrZfHxy5AWbc4hUTgljTTzvxM?=
 =?iso-8859-1?Q?sEzVTUlA5QSVMsFcl9j0BvJlFzrePUT7nmLbOwp0Z+BO94BoHnWZn0uIEz?=
 =?iso-8859-1?Q?aIasHoTUWEfXSIaOQcM4t/1l0Ksau/42F9mbj3RSLIqAqyiypCRpAGx/6p?=
 =?iso-8859-1?Q?5+jIpfTkLAeSETJmWhtjwe2amoQxFYVE3bkPmc6ijzqa0n74+H+bjLCkCE?=
 =?iso-8859-1?Q?drj3PyQm9Hay+0RGzZEkQMc16Ep+KvpZeUW80AWmU+WiOcp7vRe8tCqDdi?=
 =?iso-8859-1?Q?z6vKKXOfObnBxradhILyUTGyWNI5idDzrroHDq0gRLIcLZxkH592x93WLu?=
 =?iso-8859-1?Q?joNY4X+YR1G9kUoHiIJcjv1MxK1FsHT9sHwuKh3+qh86mWkY20LyEOwa2v?=
 =?iso-8859-1?Q?80bGeHEcBnRxF0ZLPfpeq/PxlFtXtVR9xZwl5rFF6Y/HRk6YJF4bs6rlMN?=
 =?iso-8859-1?Q?UfgtZCA8wvqcZKB4g7xoGb5QFSHTNnNOjTgG/chCZbLckQEHQTDw2jciFD?=
 =?iso-8859-1?Q?WpU3SqtD1HRpcEL8lAZ3nHqOxqeXyC3hpz4Xoq7loD5GXyMo/iKHnXx0qX?=
 =?iso-8859-1?Q?nAjxY5JNjhiyX29BW7tmk1pD0rJ27rN5qoy8sNCKChU7sk7ZZEK6CbefTw?=
 =?iso-8859-1?Q?QsQPt6l3WcN6AZ6ZxOHdDa1mhHOm3MyvzaJtVzObMw016g0svEaY8eWQ/g?=
 =?iso-8859-1?Q?nkIu8Nd2+tspfW3HcwshrIIr7YUNSaV5dy4HEauQFEV4SdJatpVg5JiniI?=
 =?iso-8859-1?Q?gxV285rbUTOc0Vprdsw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5781f1-c564-4b54-c4f5-08dc1d75103d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 07:13:00.2177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrERLy9Eoq9XbsZHMSf8E/xR2yufO7WWlCPJVnhFipQc7XIBCjk0KViRiSztefuh/881/27OYDIByf7/pA+40D0wBSeRT3xC6BbL/rnosEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7905
X-OriginatorOrg: intel.com

Hi Reinette!

On 2024-01-23 at 09:42:07 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 1/22/2024 11:58 PM, Maciej Wieczór-Retman wrote:
>> On 2024-01-22 at 08:32:36 -0800, Reinette Chatre wrote:
>>> Hi Maciej,
>>>
>>> On 1/21/2024 11:56 PM, Maciej Wieczór-Retman wrote:
>>>> Hi!
>>>>
>>>> On 2024-01-19 at 08:39:31 -0800, Reinette Chatre wrote:
>>>>> Hi Maciej,
>>>>>
>>>>> On 1/18/2024 11:37 PM, Maciej Wieczór-Retman wrote:
>>>>>> On 2024-01-18 at 09:15:46 -0800, Reinette Chatre wrote:
>>>>>>> On 1/18/2024 4:02 AM, Maciej Wieczór-Retman wrote:
>>>>>>>> On 2024-01-17 at 10:49:06 -0800, Reinette Chatre wrote:
>>>>>>>>> On 1/17/2024 12:26 AM, Maciej Wieczór-Retman wrote:
>>>>>>>>>> On 2024-01-08 at 14:42:11 -0800, Reinette Chatre wrote:
>>>>>>>>>>> On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
>>>>>>>
>>>>>>>>>>>> +	bit_center = count_bits(full_cache_mask) / 2;
>>>>>>>>>>>> +	cont_mask = full_cache_mask >> bit_center;
>>>>>>>>>>>> +
>>>>>>>>>>>> +	/* Contiguous mask write check. */
>>>>>>>>>>>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>>>>>>>>>>>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>>>>>>>>>>>> +	if (ret)
>>>>>>>>>>>> +		return ret;
>>>>>>>>>>>
>>>>>>>>>>> How will user know what failed? I am seeing this single test exercise a few scenarios
>>>>>>>>>>> and it is not obvious to me if the issue will be clear if this test,
>>>>>>>>>>> noncont_cat_run_test(), fails.
>>>>>>>>>>
>>>>>>>>>> write_schemata() either succeeds with '0' or errors out with a negative value. If
>>>>>>>>>> the contiguous mask write fails, write_schemata should print out what was wrong
>>>>>>>>>> and I believe that the test will report an error rather than failure.
>>>>>>>>>
>>>>>>>>> Right. I am trying to understand whether the user will be able to decipher what failed
>>>>>>>>> in case there is an error. Seems like in this case the user is expected to look at the
>>>>>>>>> source code of the test to understand what the test was trying to do at the time it
>>>>>>>>> encountered the failure. In this case user may be "lucky" that this test only has
>>>>>>>>> one write_schemata() call _not_ followed by a ksft_print_msg() so user can use that
>>>>>>>>> reasoning to figure out which write_schemata() failed to further dig what test was
>>>>>>>>> trying to do. 
>>>>>>>>
>>>>>>>> When a write_schemata() is executed the string that is being written gets
>>>>>>>> printed. If there are multiple calls in a single tests and one fails I'd imagine
>>>>>>>> it would be easy for the user to figure out which one failed.
>>>>>>>
>>>>>>> It would be easy for the user the figure out if (a) it is obvious to the user
>>>>>>> what schema a particular write_schema() call attempted to write and (b) all the
>>>>>>> write_schema() calls attempt to write different schema.
>>>>
>>>>>> As for (b) depends on what you meant. Other tests that run more than one
>>>>>> write_schemata() use different ones every time (CAT, MBM, MBA). Do you suggest
>>>>>> that the non-contiguous test should attempt more schematas? For example shift
>>>>>> the bit hole from one side to the other? I assumed one CBM with a centered bit
>>>>>> hole would be enough to check if non-contiguous CBM feature works properly and
>>>>>> more CBMs would be redundant.
>>>>>
>>>>> Let me try with an example.
>>>>> Scenario 1:
>>>>> The test has the following code:
>>>>> 	...
>>>>> 	write_schemata(..., "0xfff", ...);
>>>>> 	...
>>>>> 	write_schemata(..., "0xf0f", ...);
>>>>> 	...
>>>>>
>>>>> Scenario 2:
>>>>> The test has the following code:
>>>>> 	...
>>>>> 	write_schemata(..., "0xfff", ...);
>>>>> 	...
>>>>> 	write_schemata(..., "0xfff", ...);
>>>>> 	...
>>>>>
>>>>> A failure of either write_schemata() in scenario 1 will be easy to trace since 
>>>>> the schemata attempted is different in each case. The schemata printed by the
>>>>> write_schemata() error message can thus easily be connected to the specific
>>>>> write_schemata() call.
>>>>> A failure of either write_schemata() in scenario 2 is not so obvious since they
>>>>> both attempted the same schemata so the error message printed by write_schemata()
>>>>> could belong to either. 
>>>
>>>> I'm sorry to drag this thread out but I want to be sure if I'm right or are you
>>>> suggesting something and I missed it?
>>>
>>> Please just add a ksft_print_msg() to noncont_cat_run_test() when this
>>> write_schemata() fails.
>> 
>> My point all along was that if write_schemata() fails it already prints out all
>> the necessary information. I'd like to avoid adding redundant messages so please
>> take a look at how it looks now:
>
>Please consider that there may be different perspectives of "necessary information".

Oh of course. By that I meant the failed schemata which I assumed is what you
were looking for in this error handling here.

>
>> I injected write_schemata() with an error so it will take a path as if write()
>> failed with 'Permission denied' as a reason. Here is the output for L3
>> non-contiguous CAT test:
>> 
>> 	[root@spr1 ~]# ./resctrl_tests -t L3_NONCONT_CAT
>> 	TAP version 13
>> 	# Pass: Check kernel supports resctrl filesystem
>> 	# Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
>> 	# resctrl filesystem not mounted
>> 	# dmesg: [   18.579861] resctrl: L3 allocation detected
>> 	# dmesg: [   18.590395] resctrl: L2 allocation detected
>> 	# dmesg: [   18.595181] resctrl: MB allocation detected
>> 	# dmesg: [   18.599963] resctrl: L3 monitoring detected
>> 	1..1
>> 	# Starting L3_NONCONT_CAT test ...
>> 	# Mounting resctrl to "/sys/fs/resctrl"
>> 	# Write schema "L3:0=ff" to resctrl FS # write() failed : Permission denied
>> 	not ok 1 L3_NONCONT_CAT: test
>> 	# Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
>
>Understood.
>
>> Of course if you still think adding a ksft_print_msg() there would be meaningful
>> I'll try to write a sensible message. But I hope you can see what I meant when I
>> wrote that the user could already easily see what failed.
>
>I do still believe that it will be helpful if there is a ksft_print_msg() with
>something like "Unable to write contiguous CBM" or "Write of contiguous CBM failed"
>or ... ? 

Sure, I can see how that can be helpful, I'll add "Write of contiguous CBM
failed", thanks!

>
>Reinette
>

-- 
Kind regards
Maciej Wieczór-Retman

