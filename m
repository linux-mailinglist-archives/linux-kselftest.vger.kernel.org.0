Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1360E6A5A5F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Feb 2023 14:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjB1Nvq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Feb 2023 08:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjB1Nvp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Feb 2023 08:51:45 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773282E823;
        Tue, 28 Feb 2023 05:51:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjY0DV6hJANjpgjg8Xzyk83MwzvqutRbdPr732DnRBSwtJoGF9nJRz3hEeNYR7i1LUBi6MT+zgYHTsZ43q4tphqFjfAB8/1iPqjTJCqD3anZTk/EyX/lljjfbAnAAax6//N+LX6LmM0fMlhFiFtqYle3OkAG1OSDffZWzTIm/xd/JlTw7/07WZPr7C5cqVITKFg/h5DgYn0pHnW2KQkM0LNpLwdgPsY0pLRtsW/v1SErBJ+FJAeCD9PcvrTMUTcsaO/O0oLxFdVWbXUgHaCcHilnbEPAq7xhIuY/XiBstsd7Neeh+t9ubr+QI0yu46pUOFupvO4k62aQnYHXpwNV9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaEdYdBoDeFT+foGpKiiGNSSKyYzYE+28xfVk9m/Zxw=;
 b=ZUHTv6gbLfUk5RqHMsRufVGV6RWCjXHl19oUrq04Ibo9Mu2yN5imyZQ9n1AoU8XlXifWhXmXPdpTo/TziPpzvn80RFQ7oTWH7Zv+6/f9SVTFJVUnnaeiujLh7qoqWyKhw9jWu7w6U/KF6vDggwjJ6iKZ5vEMFjVF9dbckJxIE1V+JtlTqzxcrFdG1EMQWxs0BoRR1Q3qLkL5Sr/Mp0NI8qB+Gf9f3El5ahSg8LvYBuNWzS9edltbnEijwd8cD9pLJG/LO99k0ZFh7KhjAntjtc9WyaJFCXHX5jHRNwbpa4aBdZV2jHp+lfsroSB1lgNEwZIGQydFfrEqGxH63YnomQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaEdYdBoDeFT+foGpKiiGNSSKyYzYE+28xfVk9m/Zxw=;
 b=HKg0p4Kmx0CbTtfOWeo/z8hKExtYg4IngD3jy6gRPzLm1CGbgGKqGjR+IQd9D3aarMs1wW7oOUZnYLYIek3VkI742RxVxLIPFIYETUYG05txyaxRACvfcDNfPjxrKNCHeB1cezPU1eiE2Qtry4pNRKdlPCUCGWZRrLqNbuYJgZTkRSuL8mAxhweL3elUXLkaXGN3MHE6kzbhdHuYCviRbs/UvTdagkP5Gw0mTi20w3MI4TsXKkvPvWcx+OxZGr8n6K+c/+c6jrjz8Y+wQaebZHvI1M7qlZAJtcMrjTdO0Tnyi8sRQaJfQ767n9ZzmgLKE38OF+qkfuOUq5/4jHrpAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Tue, 28 Feb
 2023 13:51:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 13:51:32 +0000
Date:   Tue, 28 Feb 2023 09:51:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Message-ID: <Y/4G4u/uYA3eg7OY@nvidia.com>
References: <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <cdbc3707-d326-26d4-3adc-ff2ed80aa2ba@linux.intel.com>
 <Y/y3A4LJqunT0ZwS@nvidia.com>
 <adfd78d1-006e-5e7c-236b-cc00e8afb8c0@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfd78d1-006e-5e7c-236b-cc00e8afb8c0@linux.intel.com>
X-ClientProxiedBy: MN2PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:208:134::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b314296-ed69-4779-2686-08db1992e63d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYrSkDhQNPl/NGN080NFRH7s+1+WrLDmvbnHQcLqmEyUPXyOgEdk77bYYYDwcd1Gt7gQAuMEjNUr1xmKoYg2HCkakdpcfhLGQ3chWPBi4LdRGYdTJs0XfRhIEfKzrnehvJ9DFF1ZYrOBS/DjK2E0+5CmVKScWMpLcGdlGWnRFGqFarpZ2Jy0ScGRJ+iJQwQSh3EGb7s4dm2qRSFzehv/9ziHC1TORG55YaZef2bhSEYWnLh2tpExy0AaDtV9jOI/Z4ocRQaAbaxJMOf94tqP52ul5wZe6lT8BLmYVyC+SxjeO7NNilxhxAqh3mLi2lKGwadINJQtNA9eE1vZ+rtu71wXycYNOnsvWtVkVsI61x5F8wg6SUqhQBn7n3a4c1ngC7E9iottsi3b+lGW7pqfVtqeiO1sZRKUffQTVgCTVZnAb9za9n1jzLclmrsy0jeb9bWasbOZjnyenhTKIXEOS8vqt0i8fFfmMh7uq5KzS1JxWDjGmYefujGy4wQSgB6igq2hbxtrvwrvvBJhl7rVDc0lxpVAOwnc+UJHDGHccJy4eYcHZD3A1M1rwjv6uzp6Upw5wHEQQYSnuLPFwDHr6YrSgOPSeO8AM62StAyZdbNAbB2EDSKBNe8nRT9zvP0QdGzoU1sUplyYNljX9oKJfY1+iOVdmBV5qncGcPE/EGSfB/tGej58Wq14vcDq1dGT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199018)(83380400001)(2616005)(6506007)(66946007)(38100700002)(4326008)(41300700001)(2906002)(6916009)(8676002)(66556008)(66476007)(8936002)(26005)(186003)(5660300002)(6512007)(53546011)(6486002)(966005)(478600001)(316002)(36756003)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1JpM0iA3RiQXkAb/Zi+WNNxOMHD41mk47Ctt0Z4CCyVyrtpK5GHb9MSmV8kV?=
 =?us-ascii?Q?4LolAqLEjTqWmoXFZGDkp9oj/DxS+a3GP4bIcupd6LyjFJel+S6gFi6cvN1n?=
 =?us-ascii?Q?wuamMsj1ZtPw/zzPOuEQHDUbXDAEg7evO1D05UdtgCS4PkCxNsxHKSh/nisB?=
 =?us-ascii?Q?Dg2He2c9WO/nHRB8F0RNfzcjuH+6w+CKeUrB+SsLdwYpfChehCTriU/agX8z?=
 =?us-ascii?Q?240EKc1becZL9GvW8+MjCcnW7BcqVkLDopcGwEABb3kFOSEwp2AzndNh5CaV?=
 =?us-ascii?Q?AioUiqweFqnCElZJE4nC2sU0vXAyYzobT495h3WWMcsozdGqTedlWgKFVF3k?=
 =?us-ascii?Q?IrJEnM9iHlwE2/IxkRbNaa/M1pIpAxJWdr0MBBzAONrXgPVSXVLGm+KJErwB?=
 =?us-ascii?Q?y+oGuFbS3kT3r8YKrGThnZ5EOx0Oe0nM0e3KayGyEKhCy5GXBoym4P8U5Aud?=
 =?us-ascii?Q?gfHqI9Tg5KvEimEe0sNBoW/jFj9snZM6LlPD4ocugg5dYvcmtVJpMCSaAWbL?=
 =?us-ascii?Q?tHGqO514IizC6/X3Mp/NwttcfdEp74difk3CKau7bYcXgtBVj4rsZkg2KRbg?=
 =?us-ascii?Q?4H22xtNq/gzvDz5H4FJ0hgiBoRkDD2b8lqpZCFLDBcKMwHeyWSHPrNLofznn?=
 =?us-ascii?Q?c98te300lel51YdrRtfzN2Wt0/DyQMTimIgAxC6hbYtEpJfJ6rduSQeUcSES?=
 =?us-ascii?Q?m5s5N8I8AjetkqWJW0YxhDspswPXFFsrLzXBKrr501ReaTxDKD8SgF9zVutt?=
 =?us-ascii?Q?GMV3HEE6VpwADNBpOlOGJCsl+GeClPQgcXwMsC8QtpnQTZFyreh8TSTZEf52?=
 =?us-ascii?Q?S4itnTgcutM5oh+RAu2d3TUNduyB22Isxt6YssF7HKIIUFWKQJRxKXatFv+K?=
 =?us-ascii?Q?VHYokbBsCPQ3DODF7172B77zLZjDBB/GLOSqFJoxl5U6tpE68wgiwodc8O3K?=
 =?us-ascii?Q?f1nnBPJjcJVZme2oQl+06J2l6hHCuIuTDGd9AT+1jtULkj2qxWeED+YxdOxi?=
 =?us-ascii?Q?M/Zy62gupHzRoS414FPdorg2Q9VIHCZ3S+Jzs9Ibj4Oq81RRWgZQyRyqk0/l?=
 =?us-ascii?Q?7sh42T1ctCjvYzXQfDz4KV50sWfgSA25tOXfBmzP7l758vIh9TOczcs8IxuW?=
 =?us-ascii?Q?KBHlkSEsWZBhlvw83fFEq9bz+EmVG940Li3rRKhqkFkJ7Ylk+1NkAd/fkHfE?=
 =?us-ascii?Q?7QpL6qbWdUxopuI6vP+CHmGjE5iD89hK72TFzFlKxtU0hKOeeB+BId8awxCc?=
 =?us-ascii?Q?EVTaxujWC3DK71bxXcRx9O5QKSXi1oLDnkhowWQP916rww6WK0mVlP2lebkA?=
 =?us-ascii?Q?IsbwuqbkftA3l1YN/U5y2rFWrfJBuLsze/ltXKLr8WPxVRhpShXZ5yveAf4E?=
 =?us-ascii?Q?SXZhLLzoDiWKHnSaerGinl/jkMrNVk/MfRu3M3F3V/QugIXVvhRuPigIrn7z?=
 =?us-ascii?Q?C6mVxs9uMc5vvEFhzTT/VJXR+DOTgZ+1HRdiJ9zvM2AasUBgymKNkXsIsAXq?=
 =?us-ascii?Q?qTCn9l2I0wN0i0gMFYi1pL17Zc8Ei64600CQP2zg5ljhcbCdbvSm2K70E8fx?=
 =?us-ascii?Q?r8ranz1iqbt28o+dIJZIYoJXReiw2VEH9vO+1Wd1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b314296-ed69-4779-2686-08db1992e63d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:51:32.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNl/uphbtlxYqjG5JL/QQAEWdVBZnxFN7kMDG2owcj3URxqZdj5BjWW3nhTyTrcm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 28, 2023 at 09:50:52AM +0800, Baolu Lu wrote:
> On 2/27/23 9:58 PM, Jason Gunthorpe wrote:
> > On Sun, Feb 26, 2023 at 11:01:59AM +0800, Baolu Lu wrote:
> > > On 2/25/23 8:27 AM, Jason Gunthorpe wrote:
> > > > @@ -437,25 +517,77 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
> > > >    		struct iommufd_ioas *ioas =
> > > >    			container_of(pt_obj, struct iommufd_ioas, obj);
> > > > -		rc = iommufd_device_auto_get_domain(idev, ioas, pt_id);
> > > > -		if (rc)
> > > > +		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
> > > > +							      do_attach);
> > > > +		if (IS_ERR(destroy_hwpt))
> > > >    			goto out_put_pt_obj;
> > > >    		break;
> > > >    	}
> > > >    	default:
> > > > -		rc = -EINVAL;
> > > > +		destroy_hwpt = ERR_PTR(-EINVAL);
> > > >    		goto out_put_pt_obj;
> > > >    	}
> > > > +	iommufd_put_object(pt_obj);
> > > > -	refcount_inc(&idev->obj.users);
> > > > -	rc = 0;
> > > > +	/* This destruction has to be after we unlock everything */
> > > > +	if (destroy_hwpt)
> > > Should this be
> > > 
> > > 	if (!IS_ERR_OR_NULL(destroy_hwpt))
> > > 
> > > ?
> > Never use IS_ERR_OR_NULL ..
> 
> Can you please elaborate a bit on this? I can still see a lot of use of
> it in the tree.

Yes, sadly. It is usually some signal of toxic confusion about what
things mean.

A function that returns an ERR_PTR should very rarely return NULL, and
if it does return NULL then NULL wasn't an error.

Further you should never store an ERR_PTR in some structure and then
later try to test it, that is madness.

So with properly structured code the need should not exist.

https://lore.kernel.org/all/20130109150427.GL3931@n2100.arm.linux.org.uk/

Jason
