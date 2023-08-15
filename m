Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61E877D1DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 20:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbjHOS35 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 14:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239147AbjHOS3b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 14:29:31 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877341BEE;
        Tue, 15 Aug 2023 11:29:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m83gTkqLuN1cJcopuhRq8vkGQ44k8Y4TkMsfRhYCXbifAJdfoH7XxXrXiD1I7Eo2CcHSvDIabdRDqKdYc6SLIVwWKKYKXAfc2ry8PU9hXgZLz+guEXLxWiXT8FSxsMJJw4ww2jiZdWwfQ6yNkmR+n0St4AsCE6gAQWoyhle1kOyL/qhAIsrYwLpvB9OWE8CLkmpQqcIrB3sOs41U9PvWLUFO9uNGdff30pP+WsTMtOGllNVLdG5pa88NZft+Awprscip1a/AYIL11tl6mTsRttidAscBhX4NjyCAIbf24n34gakpHvi569iFVmnhs1CLxuSquNdsm/yLf4xJ3B010w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtNVk4b9xUCxjYyeZbTuxLk0fIt7W31r0PWyJxWyvpo=;
 b=Ku1rvqF5HmSiaZ11NDgTiAXEYxc6vb9/vglzOLvq+PIBy9YrMWaozVUp7cBQjlFTjUOMRA/2YpHW/kv9VLu/37iIF0OF+oVIqVewaYn00uVIdmPbwB6Ssmjxh5kNhh8+SV4PFLr8WTO0HQQZgOjL5kerxwwVhCZChNQnwn97HbtfiBqTPlgddbFJtjv+1zoGMx4OGr5SsfZbHTXchMwsAC+GmVsoiAqrvNp8shdJGqy6GKGDcQcLPlsV7XpMD9JRh6viSMIgr5zZB/8dIJ7WYwMFCmnZyj6/mItgMJjSMU5azpz8Mh8QV99ll2Ecp51YgjETwywEd4XeLo4JQ1NK4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtNVk4b9xUCxjYyeZbTuxLk0fIt7W31r0PWyJxWyvpo=;
 b=pdE0LvKohfa/AIJiH7AZXSOs8r7FPYC46NOx/HNpiG0Qy2+5cV+2AnRh4iDEnhidGGdOZW/SZ8pYJtOC51mjQX1eRz/WCmbDjIUV9rW1Z0pd4nrOlO8RqKSw07pumuUU5oFla586c2sBzg0ZANisaMugtsbbvcQteqJidjAH9yLFwF+fPjO8Q4FjEDxYpaUL/6o9pKpr2Wx/4E4mats1rK6c70Wd2GDytUmNPJYnUhoGLy6uWS1mQWyIfWexIGWNO5ki3HbjtO04MsJsgcny7ys2G4TadIZaGxdTJiAexQoO3aHPsWcP1I6Scs8qydunuRy95w470N5hL3xW2711MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 18:29:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 18:29:25 +0000
Date:   Tue, 15 Aug 2023 15:29:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v7 3/4] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZNvEAWF8ljWHrcws@nvidia.com>
References: <20230811071501.4126-1-yi.l.liu@intel.com>
 <20230811071501.4126-4-yi.l.liu@intel.com>
 <ZNuogZV2eEeVwNX4@nvidia.com>
 <ZNu2XWS0BERqykIA@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNu2XWS0BERqykIA@Asurada-Nvidia>
X-ClientProxiedBy: SJ0PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: af8d1717-50c3-4d84-bdb7-08db9dbd8d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOIobOgbmQP+Ca6ZrgZNa/3B7W9maRJ+DSkNUB31tpyMs+s9RQONk9zqvJrbfAOqga/w3rn973CQHsnxq/MwIC9rBBUhsxaJDQK/0G5DrICo4FqdQSnjbfAwvL9AfPyVRHLaFwKXoZbpOuCV/HfZqk0p4XJ2nFEhc+GQtwxrfEeie4P2fcdRqFq2tcUeoGfjZa5YNzQD3WGnIDvtQImWXDmRhOP2AgslNJmpsXTkB3e6quV10AT7yRRdgxQ54OPjWqWuox8fpOh1xXRsGEUmU+qEz9WMBMRTAhAcBgGc3HuTiBeQxkZ4DXR1lecW0zmjA/WtdGpB7kncYPnt3vsRVz8oEWpkZ6jXt++ccmpVOI48lF/dDR1pkdhXZoXj+NMNcL6kY6iEolJ+ZdHprvafhScki5q6li6fTHN9kaQCviRkjFQ4xGfkTjYJUkhL9VMdtJv107BbqmkZPw7Xjbw4G2yoxi/4OpPFfR2HnbtvCCRFEisq7pppxK+nfOwqYhmAnFoyBtAJTgcqkxZblnx2raS1NTpE6Ljw//16rYaiqhlF0XYywnL+TsPIuC3hkK2F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199024)(186009)(1800799009)(26005)(2616005)(41300700001)(8676002)(4326008)(6862004)(8936002)(6666004)(6486002)(6506007)(6512007)(83380400001)(316002)(6636002)(37006003)(66946007)(66556008)(66476007)(38100700002)(36756003)(86362001)(2906002)(478600001)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vffIFK/VcZjz/fyZaAtdPagZe6EH+gjfq9geKjLoVCRM6DeRhU+PRpThSPyg?=
 =?us-ascii?Q?JrXHfKJNQLuwxx1w3mlG8RYdelKavP8h0wAwsYovW8rY7C+Tqt+G/L8YMJ9y?=
 =?us-ascii?Q?aLw/78yjysPspFrPFloumpX5PMpiG0uGag6BNdxgEWABjRFRPUxxq9ZQfbS8?=
 =?us-ascii?Q?8Cpx6Sarnw8LItu59ICQ/y+0KgZvSBIdkpZrowSTBVR1aV62hIzt2utHQXHc?=
 =?us-ascii?Q?Xj5xxuGUdnNvzFyg5rA7lHmrGdaXalktbJV1GdV2DHAPAxMZBkymW4oYbiwc?=
 =?us-ascii?Q?xE/AGZs2xaMQ552oaylyo2rqL8Pw2EJyGcITS4/kIxzmW15GhIHco3tRbpcp?=
 =?us-ascii?Q?iUOzMNiwzZwdlgRzsg12TzIdZ+4DmIvu1ZxfvobA5wekCI03D3dAbcG4NtW9?=
 =?us-ascii?Q?GV0SqBfLSXkxggeMfbd+1LjGjdur7OyfMk9fSEed8/Pcye1JsP/JPGcbYVa9?=
 =?us-ascii?Q?R0ywqrhnvR1LrtKCrvLClm+ybsCZkwKhaMGzr5ekjcjVU+z4H8JOczMqcZCD?=
 =?us-ascii?Q?Kxmo15Lxlx7Ugx2Myr4EO2fs7Tth2Mpl/uU3XHPWbDOXvNG0oRXWX+fIA4jv?=
 =?us-ascii?Q?Pgm4TUgQ7tbIC/ETCHbXtteTtAZUFwV8TjuRpdOGsiLpUA8j9RJXaQa21rQ6?=
 =?us-ascii?Q?kjGKh5Q0RzkoK+uY54gWlurXeKfYs2nwYfeDCFhPN7c1rjuk5894zLPLUySR?=
 =?us-ascii?Q?cc9v8KUis2g+CF0vEA0IVhtla+Sb2ElLfw8o7NELP7+uxHTJrxlwJVqWHjR1?=
 =?us-ascii?Q?nKJg3tFMBr5dhGbCHqCNYU/jriZWWICsvadvfOGX3pmdP2xt+Q8j5Lc7H6Iv?=
 =?us-ascii?Q?noS06Z2+z/nNzhyYnhR+PTch6DtrKuja7ijy+mA0LenYOp5I1IOFTNeQAYM9?=
 =?us-ascii?Q?1aFMhgy6+bI4Qw4tfw6prebZmSBJPQL2DiJ7gcYnHg18JKLmDtFuy7Dv66E4?=
 =?us-ascii?Q?0xy0E/5eNBcYUetB+8Ca2wl9Gw9E+iEAcVwtBav+n0bj8pRcmpy7u6dnuyQS?=
 =?us-ascii?Q?AG0bf9vOv2coYB1ZnHHW7EmLN3SLwNPs3khDnNWA4orgaXwTy6RKrN718OEl?=
 =?us-ascii?Q?psu8LZSqgEM40wVYs89dOxQQFud9/mTEeosTMYJDMaWgBu92KccbGhmtGQ+0?=
 =?us-ascii?Q?cNi6/88ITyuuI4YSzSkfm61Jyr6iPKqkuTKQwFawVWOQzwWXLJSUFGtDchy+?=
 =?us-ascii?Q?xlPwZkxFupxwhstO/gIad+uXBIRNLcycpx9vnpi06qarf5SGhRkQG4llAsYu?=
 =?us-ascii?Q?jY/uO6AT9y0CZaSgSlVqNoXV9/GlKVH2NaKovxBWDVX18J8Mm+DJmt2wIO6Y?=
 =?us-ascii?Q?FYn/zIPdP5g0pbsPsIEABroUpWnLgbhElAw1oJONjgv+ZqL1MMN/RnrLygKi?=
 =?us-ascii?Q?734c3zoyBWWeHndu5SD0fP3XAmGCm6T33ITeQFPJt8+YZgrikykHlISW4Mv7?=
 =?us-ascii?Q?6CKq90lGjzK5UCnXlN0QQWXpoH2AoOj0B2HC5bB+fzAt0ZqDHKpEn9AVoanm?=
 =?us-ascii?Q?tbjh8N+kUoY+QO/gA4a9brXtjwiqoAn1VswXK8ETDIQmwnbdYHLndv/pM2Pm?=
 =?us-ascii?Q?6/Ke2cKJHKG/pkxm6niNNzb1dy8u6RQcJum3kAEo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8d1717-50c3-4d84-bdb7-08db9dbd8d5b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 18:29:25.1812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpJEXAB0tJtfgQCWnKTAkh7E/NBVJopNMefx9nqarwh5dmYi3U12L4mqZYdb4TmO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 15, 2023 at 10:31:09AM -0700, Nicolin Chen wrote:
> On Tue, Aug 15, 2023 at 01:32:01PM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 11, 2023 at 12:15:00AM -0700, Yi Liu wrote:
> > 
> > > +static int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
> > > +{
> > > +	struct iommu_hw_info *cmd = ucmd->cmd;
> > > +	unsigned int length = cmd->data_len;
> > > +	struct iommufd_device *idev;
> > > +	void __user *user_ptr;
> > > +	u32 hw_info_type;
> > > +	int rc = 0;
> > > +
> > > +	if (cmd->flags || cmd->__reserved || !cmd->data_len)
> > > +		return -EOPNOTSUPP;
> > 
> > Is there a reason to block 0 data_len? I think this should work. The
> > code looks OK?
> 
> I did a quick test passing !data_len and !data_ptr. And it works
> by returning the type only.
> 
> Yet, in that case, should we mention this in the uAPI kdoc? It
> feels to me that the uAPI always expects user space to read out
> a length of data.

Well the way it ought to work is that userspace can pass in 0 length
and the kernel will return the correct length

So maybe this does need resending with this removed:

	*length = min(*length, data_len);

Also I see clear_user is called wrong, it doesn't return errno.

Please check and repost it ASAP I will update the branch. Probably
needs some doc adjusting too.

I came up with this:

int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
{
	struct iommu_hw_info *cmd = ucmd->cmd;
	void __user *user_ptr = u64_to_user_ptr(cmd->data_ptr);
	const struct iommu_ops *ops;
	struct iommufd_device *idev;
	unsigned int data_len;
	unsigned int copy_len;
	void *data = NULL;
	int rc;

	if (cmd->flags || cmd->__reserved)
		return -EOPNOTSUPP;

	idev = iommufd_get_device(ucmd, cmd->dev_id);
	if (IS_ERR(idev))
		return PTR_ERR(idev);

	ops = dev_iommu_ops(idev->dev);
	if (!ops->hw_info) {
		data = ops->hw_info(idev->dev, &data_len, &cmd->out_data_type);
		if (IS_ERR(data)) {
			rc = PTR_ERR(data);
			goto err_put;
		}

		/*
		 * drivers that have hw_info callback should have a unique
		 * iommu_hw_info_type.
		 */
		if (WARN_ON_ONCE(cmd->out_data_type ==
				 IOMMU_HW_INFO_TYPE_NONE)) {
			rc = -ENODEV;
			goto out;
		}
	} else {
		cmd->out_data_type = IOMMU_HW_INFO_TYPE_NONE;
		data_len = 0;
		data = NULL;
	}

	copy_len = min(cmd->data_len, data_len);
	if (copy_to_user(user_ptr, data, copy_len)) {
		rc = -EFAULT;
		goto out;
	}

	/*
	 * Zero the trailing bytes if the user buffer is bigger than the
	 * data size kernel actually has.
	 */
	if (copy_len < cmd->data_len) {
		if (clear_user(user_ptr + copy_len, cmd->data_len - copy_len)) {
			rc = -EFAULT;
			goto out;
		}
	}

	/*
	 * We return the length the kernel supports so userspace may know what
	 * the kernel capability is. It could be larger than the input buffer.
	 */
	cmd->data_len = data_len;

	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
out:
	kfree(data);
err_put:
	iommufd_put_object(&idev->obj);
	return rc;
}
