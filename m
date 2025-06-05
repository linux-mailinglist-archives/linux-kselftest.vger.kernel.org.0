Return-Path: <linux-kselftest+bounces-34402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFD2ACF829
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 21:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FD43AFCAE
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 19:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A631627B51A;
	Thu,  5 Jun 2025 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n3E9o5zr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF220C497;
	Thu,  5 Jun 2025 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749152440; cv=fail; b=IGtH/54dIknfzENZbCibM9/E4PXOJ7iZ5pKGzbRshqEsE3zV8nCB8nlJbCY8zaEM13GNqs5XA75WzpOCP+IkNGzXLEyADlCSbkPT9gBeVtVTelSNwui17fYRTQgz7CI8CnuKVeGnXeD+4XCdPbTs6ifSVwMFI4I0ZQGeru7VgoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749152440; c=relaxed/simple;
	bh=yi+f3d5P/yOhyxhl6uokHMWiIWEqjVGGVf8PhxLuY7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eUAqb1yv2qSWYlumSM68EB1+PR/jInsNjXHm1eyoUQpPqD9GprECSr/8d+vHR8FhU5GoajRZ2Ej2kvzmJ/7VsT1U27nF4GwqPk8Lug3oraovIv11vuMRWmDOP4vKFsPsATm9l/otfE/T3Jm5dKlsfTYcoTK+9cSdcUWHoxRBRkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n3E9o5zr; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2MkvZr1+yl39ZaPLcpZsPINkbEJ82pNOI3Zr1YkS244BzdyqSukpz3uzKdkiwaoeOmZXx7Zen1d/I5Cq1G1mSUPobq2FixLl7AAUzVB8cHabWDSDfmkeuw4Kn5bCtjIm+22ZM65aYAyZ1HTaR6EdZEwVV1TeMEIh2F5NKjdM/aWLF5j7qGiLHempSWHpj58oEe9oZhCzfzQEvHgoyRo9YgRtKgq4+U/gxHDmBBGcWrL6AET0q+CQxrEleLWDlw9HaaBc8cLNhSudsBjUe5gNZkg1NQ2oERev/wvvL+VUtA6wdhaDv3aaG7xU3htVXolA8OCabOE0hzFnQNn/ZwZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4OOMDk1aRmcPuVJ6Z2ciUvkgjvJGT5f24nhCfaT2zM=;
 b=di3Q46KcR3sqkkWEwUcZmqXCC8vsaV1ACWef+Uyv84SMSAgrS0p/K/sAJIGAUVHWg0lqG5qeRRB8j1VNK8dos4CZdmlO/9V8/xxtMo9ewQzucH4I/pbRZx/8+udeNHkc3yPgaA/cgHf5OljqArHl4KbKDHq9t0WQ6sHOBFkpeSeUrAsU9PcEAGEBd1/hQ0Ctv4jc5LaG2oekDgKWaL3DfHCjsem5RpzewZzBR6sF9EfYY76BtxmsEvFzrCVvV412cl9huJ4zNnhlUQ+dMWVApCs4P4XkohuM9wdBDLBFEymRel5CPNy5GLTpbUu7jF+UqfmbEIyLSagKtq9atBfB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4OOMDk1aRmcPuVJ6Z2ciUvkgjvJGT5f24nhCfaT2zM=;
 b=n3E9o5zrfn9+mpE36epu8zjQZR8vaYz3RGu9FfwyGErlgjBljw6dQjBvYnwocHIaRry79lilWABKdLBuZvThNXacovYYHBKEvFzzEc212o9N6E4KEqxllwmh2RYJaiw1xBOgXvVcCAIprKBautr6uCGGRcgx+J4XEM4hnmybliy9AoAyx3SjEl0r2/XhMOFkIGYMCe8kehA8mapBg5WCBtVBAM/NhKPGNSVm1XsTeLlcfdrAgxUhxnNPW9l9vf2hDOAD8y6/rih/7Naf2vXGg/7YuL7cVhY55OmlqNJK+5Lqn+JXTDH/9UnJDSB3jbRa09Rc394c4vVnLqBksOwSDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 19:40:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 19:40:35 +0000
Date: Thu, 5 Jun 2025 16:40:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v5 10/29] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <20250605194034.GF19710@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <49f7143c1b513049fd8158278a11d9f8b6c837d3.1747537752.git.nicolinc@nvidia.com>
 <20250528171754.GY61950@nvidia.com>
 <aEEY28ZXH+NqiE+T@Asurada-Nvidia>
 <20250605151648.GD19710@nvidia.com>
 <aEHOI522eucrOZyI@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEHOI522eucrOZyI@Asurada-Nvidia>
X-ClientProxiedBy: YT4PR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 835d488b-c92f-48dd-bffd-08dda468d794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TAjkhcOxNW7bI0l0cdK9k3B41LOuYDGPNrQ57YoiYie84GGikDOcjyk0au/8?=
 =?us-ascii?Q?22xIqfT3nnaLFqaDuHzsX9yPDRf3SuBlujG5gPTLwSGTSc2FVFZ8UWmE51jZ?=
 =?us-ascii?Q?m/NLCGzvreQ9FpJLyftA2j/PwFEcAb12GanTvRp+KsuH2GIWtpTV2dYAGk0b?=
 =?us-ascii?Q?chFrYp3itebRQQJeRtRFJszU4XpSlYiH41lc5LKDxwmzT+zNb7pxwMYimi+a?=
 =?us-ascii?Q?h+5K0FFGare+L6VxZm5HMYnkhCsYtv4EU8x73hNomfzDCj+0DIaqxrJ5/HJF?=
 =?us-ascii?Q?Ekix84+gT+0zgMaoIOro39FEjPIhquqwB6b3diH6WfDGTy8aMeLHRi4E58fQ?=
 =?us-ascii?Q?IrrXN1+mEWQlWNWZIwTQA9THh+6YUZUAXb2UW6UrKOqrSUjNCJuMZ5r3uyLN?=
 =?us-ascii?Q?VlU+h5ItUXlkSmCFCo/GXQoCXpA1tcLDKtrt8TRuIbTe/BvllHJk8ExSVFHw?=
 =?us-ascii?Q?1lB5kMGRE9hnvKXCDLPzuveQfXvXxwFNwo0dSwqCqFD6tkLctUYgVT5wPVtZ?=
 =?us-ascii?Q?P6BXvJfqTuvnMqkvSVP8eJ8CyO1v/rZKz1CpNKVoHlz/DyEYrFVFxtgsWZq0?=
 =?us-ascii?Q?xeyMAGTgUOVsQsaI/9jt7Om39+0C50kziv8Dain9GEL/pSXmTbP5mX8rZEfQ?=
 =?us-ascii?Q?sWOmesl9l7p4jUS2sFO9AEuvDTNKSaMSSEqK3hLEWr/HnXURgFyOtARsSvV9?=
 =?us-ascii?Q?YTm3k4enrAzVskG1BX+/02qurt/EmQLwR9WfoClP/9l3nz1pp/hNrlXqmtJr?=
 =?us-ascii?Q?FyMp6uM23mv6BAvZqVdlfpWdPdsVJfBCk5LavVXD8snm2RRLPS22bKYgSgkZ?=
 =?us-ascii?Q?u8v9Y7fo7HY3tjEi46vH8PVO6nd/0H1Sfpz1vkYiSW4c+56D3SalEoDg/bDt?=
 =?us-ascii?Q?4UR07HBobpR3q4hL2KkRaFct7BnTWgUtFhuawDj5ANkZaYEwS9EI/WUObyUu?=
 =?us-ascii?Q?WlCNRCJhyi9tBJy2Z2BJ+sIPsbYTWKe6h2m5oExM6SS53HoJ3NKQcZO2R1RR?=
 =?us-ascii?Q?/1S5urk1dPPrg/JEwHLhOBLWx4Lip5cBN2K7GlumvATYdhhYVWcZIvJwMq2p?=
 =?us-ascii?Q?A9r327rKsODB2nY/InqI+EhiMoy8uLMweSXIkwIyO/eGpxBcMSNxHc77ZvWI?=
 =?us-ascii?Q?c9ANxWPqVHZo4uw3SW4h374LJNmOoJH5VM9yM1It+9ghiJXKugizdsoSpwh9?=
 =?us-ascii?Q?+3pj/mRcEKYBmP/oy7moOlrh7n33uJsRndCUTTFoO68nWzmBrzajR4kzPIsc?=
 =?us-ascii?Q?i8i7F4UeJLj/RGycA3N0jWnk1Xv3AUuGt9XtgkTCADNfPXEue6PXMxR4uxkj?=
 =?us-ascii?Q?VaE63Bfqul9RAgTxuabe7ouIyRv4R9YKvaDfB0p8sFSesEgen4860bMoLxzx?=
 =?us-ascii?Q?x63i0jnYjxoUwCCj2m9/qP5OhG31oITIAwiK4MJuCZ9UdsTqeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4wF8f2WmN/r4x1dMbvqTx30SVlFGJMaGWmlOvseAdjkIn/AqFmllswgsXlzJ?=
 =?us-ascii?Q?T16BouJtLkbuJDffdCa+4jEqzb9t9GDh8OQIfBtuRRSsR4GJUND/UymCE1aE?=
 =?us-ascii?Q?7y3faRtkmIPxkrNo4itQnYezqSYVclrByMzjEKOsmEVjthUieOzAtzk44U43?=
 =?us-ascii?Q?h0+04DHrBTiwqngliYC0Jmum8BDmljyh+lf1TJg9KrQ0mgKKBPXViG9Zq9DW?=
 =?us-ascii?Q?SfwnSUCowfwmw/9DQo9pBrfnCTCiYuYqPVOAStkjpOmWmi0vkaF4kM31oe7u?=
 =?us-ascii?Q?RZEcFUDfUUnCrpocWTQFqZT0kQMiHAGzcOyEbzBbadG8hzfKgRFoI+u1N9Jd?=
 =?us-ascii?Q?yelZL0RBFgRXddAQmNEIKlOTMQVLfbKANYWYQtDY+AKGyKr45wDA+h/b1t/g?=
 =?us-ascii?Q?3+RBjtTiIJn4nxy+F4qiLO07NdFy22If3J+iBHAepd8uSc+wTSYJw/HxPv62?=
 =?us-ascii?Q?7A3mVBuWxD3183x4891Vfao8pwHmDHMra6MtMJvi/NolaH2LV66LSfo3PkBD?=
 =?us-ascii?Q?zlapFDGBRooq3hk2UR7yQ3WAq69Xowz8bqFzw0AUdoazpuCCupxTD4UqXhMz?=
 =?us-ascii?Q?ykIzbvqPO2Z8AFdcpdkuNS7eSndWo4yplNoxULYObFIyyH7BE0SN0mV7MPDC?=
 =?us-ascii?Q?2uO1L7pwr/bbCy0AgtF8EXmjSBRBuGDvI9dljSiFUUVNNo7J0kvRj44twvhz?=
 =?us-ascii?Q?hbL3qSO/WMZLJWHJotBhbpKehiKfwWb78sKDuFzrSipdwhpkdeDsXKiuWIvt?=
 =?us-ascii?Q?95vs6XLicpVxE7VDY006BRn0URMINJxGfwcqbGTI8k92/36+vUWP8uqLCjyX?=
 =?us-ascii?Q?X5W1rTqUKiIAE+/FPH3JKdKmrXXJ39cUxUlBtriAOiy3+m3WEyfKsS8qkgRB?=
 =?us-ascii?Q?jlHxKk2XXBnCgRedz8KV6Z022gN0geJ3Sdv+Omj7xiVyb/i4OAvjZ+o4PHHf?=
 =?us-ascii?Q?DGxoL4bt4HS1HrDwhA5a9IIvN2+U45qa39PjeizYLzIJ2gxJiOA7TDTAhc7M?=
 =?us-ascii?Q?y1TzkI9j9YCl4bOqnW7JYIwUqLVyWp9x1LZxyZ1TsYKnQuP9M0brO4AZCwd5?=
 =?us-ascii?Q?GrX7/gLP6+Rwvur522P759dZ+1XVRaAWT+n6rBdvldEQDxwPMRIIktjAwWn5?=
 =?us-ascii?Q?77TQg4lNvasV7KilNbnrl5JD1M6owego3DIaZgYVR1N4KiirgMGpn9Sp6PEw?=
 =?us-ascii?Q?AQn057SLwEdlfVJdvuI6RKacGaHxivj+d+qspuraIsoZ5zQjPCky2WGf5MoV?=
 =?us-ascii?Q?9OSYnlXCYtNQRCAmKIM740l9vAXVjtXM3qLnvQa6RtlJF/tVcpgg/imfq8eW?=
 =?us-ascii?Q?gZbFMJZbLaYdcsog+fWqoVhqYcldxD0sxFjk0dp2A7W48Efl+EuGu7qHPVUJ?=
 =?us-ascii?Q?3JNpi7zhcHIevjcHPpX/gXaey5dC/CvrJ9QlLi+ElI4saLWFFI/TFI5uRF2z?=
 =?us-ascii?Q?x6Z67sisBfBfH/litmFcFKwrNzdfEiPIPgus2gWy7tJw/5qHCdYNSjmYXVKh?=
 =?us-ascii?Q?7JpGqSH8lil3Vl3y0qwCYwxHyWLbmyCUMa6i5mOZiK5R+jf6OKoeJL3JOOnz?=
 =?us-ascii?Q?rf7NSBPXYiZAUJ16Z5QB3hk7pj3/JUc6kP7QmgaI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835d488b-c92f-48dd-bffd-08dda468d794
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 19:40:35.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTF4fRKDRLjhMF74Xt6y0ddDiYrDvf9WOHCO8YaRIpZNYE0A3RnwLbnq2pCklVDi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865

On Thu, Jun 05, 2025 at 10:04:35AM -0700, Nicolin Chen wrote:
> On Thu, Jun 05, 2025 at 12:16:48PM -0300, Jason Gunthorpe wrote:
> > On Wed, Jun 04, 2025 at 09:11:07PM -0700, Nicolin Chen wrote:
> > 
> > > I found the entire ictx would be locked by iommufd_access_create(),
> > > then the release fop couldn't even get invoked to destroy objects.
> > 
> > Yes, that makes sense..
> > 
> > It looks to me like you can safely leave ictx as NULL instead of
> > adding a flag? That would be nicer than leaving a unrefcounted
> > pointer floating around..
> 
> Hmm, there are a few iommufd_get_object calls using access->ictx
> in iommufd_access_attach() and iommufd_access_destroy().

I counted:

iommufd_access_change_ioas_id
 * Don't call this
iommufd_access_destroy_object
 * Don't put if null
iommufd_access_create
 * Don't set it
iommufd_access_destroy
 * Call iommufd_object_destroy_user directly
iommufd_access_notify_unmap
 * Check for null access->ops->unmap and skip the lock_obj/put_obj

Jason

