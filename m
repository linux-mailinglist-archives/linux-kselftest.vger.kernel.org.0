Return-Path: <linux-kselftest+bounces-15669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DB9957243
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60F29B20A8E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 17:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6405218787A;
	Mon, 19 Aug 2024 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E34H+bcj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A525117557E;
	Mon, 19 Aug 2024 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088984; cv=fail; b=LEdMLX7tEGNcYbuc2wu2vhDOBWlYuYBWoryPR6/GAnxJO6fNRix5AnLsNuk/7+zVyxDohL80xO7RtgDjVpiohtKro8Q2Y6WKH3/IJqK/dRoTFt/jqz5teW8ie4ND3VZK1PEoAHZpXSHX3QydMlZewtT3cTEnNqMOn9qR29lS3AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088984; c=relaxed/simple;
	bh=tTcbADklC4ys7Zzag+PnoLV28YJQnYtLMPHPojZwc6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=axLgUYTF2Y1JL6X2t2Kc0ue63jaCvfqb2ioBxh61scONwY3I42T8BBsCWbnVMihf1yoo5g1u37/Jo2KSDJgWOX2VGyVBbMa+g4bP18hAZW/lgj3oL3uabRv6mnDxB4o/w3sWmNNSAvA8wSyeMDdeBvW4VldcC7UkXfs4pZycUBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E34H+bcj; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XH8PutGePsZv4yTkYnE3R/xVpJ6quoMBtXKSWRfN4/48vgh8lFt2Qsnc0xvdp5L4n1LyRrHvkHn2EqwIhaGMqW0lTmC0oSHXKGj1PmPIFbwOR25g8aug8T4MS+hSqCZ54dY/hczkeJS6yNmDN9DQEcZMJRudbzMgMiMz6rj8kjUWHXu/Mm6Ey3tP2/3wo01ZmH8gNNi41RwwfmKyNAAiEKMKTy4ajaQ1+E1kV3XRS5BLw9L855DbqdJUir4PgrUz5iIoJgPuXlM6tB30lHXPSdOIAiYs4uBt+uzNmQZGAFAcY4EvIVgChTVUWZeU+jhAK1tSLwJ49qPyuabUY2sxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZcm7E1zk5TW7hYjPOq/Vbb3nopkdvLlRjaeyNr27SU=;
 b=wo+JznXlmBfLvaljRtoeRxzM0li4x9akf/0UeOhW9j3U0QM9St7HEAcx9qpN+3+mxAPloZvGvMY8NGlSTVaMfR7slKjSoCoH07daEKhTerOpe+xDaEcGJAvPDIzvPMlHQXpGhGOCnn3eBfFfyjzOLmakQ+4GO48MX6wpCeVJVNLlBtbNghARmZ+da96ukCiKBqx6KKdqbMWGDBYylg3fjFQ4RS/auZUhLHNPWGEZsRnKMNU2SkSlHiJczt7v2VDKnPQ8wgnHFjqa7lpMFXGMCHG+7b76OVYKlEa4VjvA3oQjeuxQJ5kHZI+SAGr/LEfzbWwXgHf1LyciXmykCB32nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZcm7E1zk5TW7hYjPOq/Vbb3nopkdvLlRjaeyNr27SU=;
 b=E34H+bcjF3QMGAchgc/QKa1lzFPpty+wpgCSvX6nGRkX4x1aQ66vbBgPUsxI/vrASOa6ipN6qmurIIS/oXE4Fr/yws3fOWkJJwQimN4+qnBMCxsF2RtwJ5IFa/Gnu/mlDfletKSCfUnc5kMcMtndAMdeFihfR0CdH19Xd4Bnuap1SWq6nay/K4XA3mRAcK7ecRJr8MWkK9awrKJt5sakphSvzSjtZkQ/RBTFR32Vv9fACAa0ZUTptwTZirI41kO85dFlT4TLqPX/xrtEFPHJI2tXjnQwRlvnlsGkT4u0xLESpn8s0oLXmG7JnHyVw2DVeJNsTxLG2Tg3+oM2zTrW8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:36:17 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:36:17 +0000
Date: Mon, 19 Aug 2024 14:36:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 15/16] iommu/arm-smmu-v3: Add viommu cache
 invalidation support
Message-ID: <20240819173615.GN2032816@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <729dfd0808f85d88fd3ef8bcea0168cc1d2c0d59.1723061378.git.nicolinc@nvidia.com>
 <20240815233635.GV2032816@nvidia.com>
 <Zr6iPtiZ/afonJ5k@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr6iPtiZ/afonJ5k@Asurada-Nvidia>
X-ClientProxiedBy: BN0PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:408:e7::14) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: e43ae003-92c3-453e-7acb-08dcc0756e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NRidhjGEarDgN1b5Kz5RkSh9eYanMwabWjwrYVASNXzVd1zDcI8kJQiye7DL?=
 =?us-ascii?Q?QO4kWcXttYzSzRGKj3aXxPj4JQzDBmXWhss2iBg55Jp5jr40ZK+uRndy/tt9?=
 =?us-ascii?Q?k0WDErQSh/Jzp6At3lgXdatsRFTfhHb9dD1VkseObUBZ8m+j9uVCU5oAyW9K?=
 =?us-ascii?Q?+qtVCSonhRjx30HJQx4I4cVMbXjFzqTHCsov56rgHJJkOo72mkRLWuGP+G7M?=
 =?us-ascii?Q?vYNCyoXvh9HUNZrphdrCQWmvwkJ24k0G2NpEpI659I2FD8cB+Udqn8GLOvg0?=
 =?us-ascii?Q?3tXOWWrbo7V6cuWdnUZc8ZFpy32S/orZhxwSwXOHgpW2rz7R+fC4VAx5CYVO?=
 =?us-ascii?Q?nEnmokx9ST3ZLwd21iRlzmbujaBXXChPe+nKykDgQlbFloFgISKbQDFbGTdO?=
 =?us-ascii?Q?2eb3cadvI8Mp5BChtbFzlq7IU990ZFwoW3QOjitar8TCDUNmvrqhQVOTlt4d?=
 =?us-ascii?Q?2zEGPlsMivNd03jklTeHbE/XUKaUlB+Hb9xtV7nCMkD7udbi6DxFgnx1X/9u?=
 =?us-ascii?Q?cYQQ0qOygYxIS9Y+W+md7psrtDMIgMM3Wb7VI0Hmd/7j2UKcgQCFagnVHEXq?=
 =?us-ascii?Q?yj9Rrb6ti0IY+xPtsN6MFNkOOI0degZgrlVqXGI6LFbt2dtjvPR6nxHhRx3F?=
 =?us-ascii?Q?4cA6MGwiEgrPmaybp6uWFm+46JOkIAL5xvk3hg6hu68j4SJsBntrH38BFc7N?=
 =?us-ascii?Q?mcTX/1X3px4/RvdA5bQA5Mbdq8Hag1Z17MsfRrnHrtmpjiPD0jF5FnN58gsf?=
 =?us-ascii?Q?uAiMMVg3toCXE91toYKp5QnZ4nuJUA/JzaxDEfK9NjAXl7PrRT94D58UQ1X1?=
 =?us-ascii?Q?GibkyqvtY+m54vh2mTllTy+Lo/+U0iTsFFD41nrlmoxO6bJ3koBB4Vil86YH?=
 =?us-ascii?Q?qgp1pzlhoSFIgkUozglup6sWhgYEVZCDUyTuYj9NKd3lbJ/bMH/pLm7kZZVC?=
 =?us-ascii?Q?RNbYJSa930KnLhbx4pblC7wQyuvYU97cgXW9p93BR43CnKen6B5DvG4as4Me?=
 =?us-ascii?Q?Pw8rruZGclFWeKX3wlCRdiw+kY19+yXitFoG/S19b3ifNsnZ2JLIhN7ooYjk?=
 =?us-ascii?Q?La/Q7geAu426+rGrHbciPxLo2oFkIPaEG76a+zAj4CV5NPh5fwv0RZTVSVkG?=
 =?us-ascii?Q?h7lybvOfww4AKdxUb+kS3rUtab1BJHnAN9NRn2AcwELRsh6oHgSyj2GiIgOH?=
 =?us-ascii?Q?LWHZuBWYRtSKE25nCkVDud2BG4YDo8kBVlom4rJ61urKTPAQ9UXARd/+GPIV?=
 =?us-ascii?Q?6SZymDZW/sVvweU8veGV5NWDE/5NCSfUtEphdrX5jNaJqQj+qZI46bCAAFTW?=
 =?us-ascii?Q?0cEOye/YX1RNnsfLppPBs9gFcOFtjlTyGUkKivxT/neaCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ClvKHtr2KGi6uS4hDtFyNZ6DluG0Xo2FAySXZy5k78mXR0yHD6v9rjTBBbKu?=
 =?us-ascii?Q?3jAtGZv+PQ5IpmsZp+aG67o39IA9LgrTDFJi6ePXzB1pz3e5ACrDnbyFSJ45?=
 =?us-ascii?Q?GYnARvYEES1V8rocw2ONL8oI4cVehcCIVzcin39E0SBzmpYn5I0hkTLXwKoh?=
 =?us-ascii?Q?JNzoZREUnE0F1VpLIRquB2tk90JDJIbyFILgJyOh8iOIkE/GFBW/HLgY08Fh?=
 =?us-ascii?Q?e5s0e5BdWdm/oQdh5kEJ+gT8YRa2EQ3WEwqrHd3QYnDQiopQjmyuQ5HNlY9o?=
 =?us-ascii?Q?TM96tW7HOayFknq+VLfcpkeW6sgSCeAzU5UGscT6ySAqcExUiFoWUXHpU4LN?=
 =?us-ascii?Q?YS2dvNrkJSYzjRlxTxgf7mdVzOZrnYYQRf7kirI1IgydTAqBE75qrcPxcq9d?=
 =?us-ascii?Q?QMtYmBQxL/Yo7mRpwsvlOEw8EPvtPysoEX4/FixifPXx41WANLFw997elNUV?=
 =?us-ascii?Q?ZK9h3HPNpuLepvk873vURF11lryG5yzHjUe8GtaIE1dhiFTjtGReE2WXVQDj?=
 =?us-ascii?Q?h0mIuJyi8wpF15TqT5jbsebU6pAW8XMbGLpaa4lfaR8U/uH0T87yxJkseWvi?=
 =?us-ascii?Q?KXUiWOai3jxWOLl1isTDQJZ6yRezJr8SseEDovXCilBp7cd6hgFdfnll4V3Z?=
 =?us-ascii?Q?xrzhRZqJ6ogdHM51UjOC2GEGOV6SGQ5+OVeGXRkc9I3z5Pfv/0YEoLPUdFIH?=
 =?us-ascii?Q?arnkCeB4dSslra74Bo26koe6aSEFfDlhyHYdvHBW7Cc3WqbPn5SrQaUpxh5f?=
 =?us-ascii?Q?YrWs9lwaw/FYSx3M4nlSlWsVNswxkHmwBra36oYIfBdpCjAP56q/GrWRf2Pi?=
 =?us-ascii?Q?JHcG8HP2BMpINIPGaFOMeaA9l1fGMWQJdEMbe0EwQanJJXuEt8Jwk3dHdDWM?=
 =?us-ascii?Q?1nCa0fmr1NCj/wiNBdsjGv42R9UkvS+BIy3EfA2D6uTk8Y4aHrpEm1oC72aa?=
 =?us-ascii?Q?bpesz/MOcrmDAoNIPFUu9gQwAMHZua2JEpxHVcczNPoh9I1hUUU16ylV9WL/?=
 =?us-ascii?Q?A3wgRuzsz3WugfOeoIP+9cKKxrUVEJFyS0iyI2Mwm1XO4zwL7Gp6Hsxu+Qlc?=
 =?us-ascii?Q?LBiBTO0XdQTMQTZ5FLxAE9VHBUsQRE8YAl14D3SvPXQEgO39OrJlX5ZgdjpE?=
 =?us-ascii?Q?zX4uEzor0gtF+kfi7oY49+NGTOTjz3/ZIL1zW+TRlzCw1kJAr/xXvPuLXHI5?=
 =?us-ascii?Q?U1Otp+2sRq0Ne2l1StfxwGsXr5rBp1+h2z+daOZPqh75zgl7eCmOijvurYDb?=
 =?us-ascii?Q?YHqLf7splVWePbIjuDuBgzqNpLxSxMrqb6O1JvtDAulSl3PnUUFWGAhyVDCM?=
 =?us-ascii?Q?7ns0lN3fQtJRtIRDKz++qtyEJxc80sqnDMjxukf8s4gVbCj8fg7Ckvk8zGKA?=
 =?us-ascii?Q?9jiPUdk2DeVx7PDfNkx7w8DMHLCU5h659zDn5XuCszXNalzzk8RUrlgBQRMn?=
 =?us-ascii?Q?AJNMpvTFOEaBqQ/mqfJk6AvKLsjN8Gse5e79r/Z7Q4racTCIIzeLsyopN9gp?=
 =?us-ascii?Q?9XhVpgf2/LTQlV7lfN6M3c+lHBjRlbAD+7VxNKBFcm8eELrMYohkxLge+ZvE?=
 =?us-ascii?Q?nn7FLP2JkQxrznabd/KeScaRJWqZrUHMdR4j/yif?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43ae003-92c3-453e-7acb-08dcc0756e00
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:36:17.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9d+xN3lTuBQ//JLPr3kHyZGOzqCKIYGFGeuxjNU6XfjPlA737SeVSOegac6jINGG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458

On Thu, Aug 15, 2024 at 05:50:06PM -0700, Nicolin Chen wrote:

> Though only driver would know whether it would eventually access
> the vdev_id list, I'd like to keep things in the way of having a
> core-managed VIOMMU object (IOMMU_VIOMMU_TYPE_DEFAULT), so the
> viommu invalidation handler could have a lock at its top level to
> protect any potential access to the vdev_id list.

It is a bit tortured to keep the xarray hidden. It would be better to
find a way to expose the right struct to the driver.

> > > @@ -3249,6 +3266,19 @@ arm_smmu_convert_user_cmd(struct arm_smmu_domain *s2_parent,
> > >  		cmd->cmd[0] &= ~CMDQ_TLBI_0_VMID;
> > >  		cmd->cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vmid);
> > >  		break;
> > > +	case CMDQ_OP_ATC_INV:
> > > +	case CMDQ_OP_CFGI_CD:
> > > +	case CMDQ_OP_CFGI_CD_ALL:
> > 
> > Oh, I didn't catch on that CD was needing this too.. :\
> 
> Well, viommu cache has a very wide range :)
> 
> > That makes the other op much more useless than I expected. I really
> > wanted to break these two series apart.
> 
> HWPT invalidate and VIOMMU invalidate are somewhat duplicated in
> both concept and implementation for SMMUv3. It's not a problem to
> have both but practically I can't think of the reason why VMM not
> simply stick to the wider VIOMMU invalidate uAPI alone..
> 
> > Maybe we need to drop the hwpt invalidation from the other series and
> 
> Yea, the hwpt invalidate is just one patch in your series, it's
> easy to move if we want to.

> > aim to merge this all together through the iommufd tree.
> 
> I have been hoping for that, as you can see those driver patches
> are included here :)

Well, this series has to go through iommufd of course

I was hoping will could take the nesting enablement and we'd do the
viommu next window.

But nesting enablment with out viommu is alot less useful than I had
thought :(

So maybe Will acks the nesting patches and we take the bunch together.

Jason

