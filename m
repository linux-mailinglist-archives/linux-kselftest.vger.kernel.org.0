Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4652136161
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2020 20:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbgAITsP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jan 2020 14:48:15 -0500
Received: from mail-vi1eur05on2057.outbound.protection.outlook.com ([40.107.21.57]:6222
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731138AbgAITsP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jan 2020 14:48:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hwfp8TtwGqvTImFDZYBVlX9FgihV9d+csm1l2gL61UuSoK7U2fDFE92F+s5wPcBX2+OZmJ6gR+PkyKmBIljwVyfDcgKZKpoDQEzSarvKszguDIGhrwQ/B44Pw2uK16NMev4MdNBzLlhCxQ81IHdH8lZ50vaVTgfvOpOUIBvQS4Q8c0R8PmVCy49u6tCuXElozGJQXbtdXBvlcE2MMhEDmHr1SsvT5pcUMw+lxBalBj/fGStT+F4DXb0sWQv5MdQfW/MaSBB8dpXghcOa4yUcP5owmjZtX2jxV0v3OHwtv706+gK7Ij/1W/1lz9NIQTEaQGDk4KZVdSxFpvIw/8vXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE6q2D6OSiBtjRvDCDTsxV4J6IlGtGLxYfSzZ2KLa18=;
 b=XacD9a6GOhuNuF5dlQw5hKtDzBXPCXi87XOJbgcNimbERGtLUCTWxhRnIaHeAaWqldZZv2cmXJ+8QlqzGOjgOaquf1mnUO6UEdj7KQlfjzfcYXGf6anbuuC3RAs7TR2RSWHhuDYQ9KXbf2sJnSB0JlVNFE1hL6+zhULPDYJsLzktI01MFiqwYkTkBJZOhl+t7we59kWxyd7kXa7oadYROWVFFcq23zn/j9/JutQuXEJjjMMvt5ou7hGJiG+MfXea/RKtzfWgYCW5LN/15JZ5QVLOMXlQ8oONI2rbCiKa8LWz9NX6pp2VENMTDEeKv3IxYLs8VlF/bMhr6JFcTCCFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE6q2D6OSiBtjRvDCDTsxV4J6IlGtGLxYfSzZ2KLa18=;
 b=L6wpL2TqXDBUu7ZYv1GhsCoWdZkJEfREQ5rxZK1+gAvBoWCTlZOLw/vQ4NVwKhBjbXOhthg7R0tpcrxhfCzXZHOxPa/4d1Gvv2w5JvMKVJ3ivHBa+2nlNzO38GNRbR9Egj8eAm/kDq0DRPVFKd52g28TIYKrxWJjAz0eiY44ufU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6653.eurprd05.prod.outlook.com (10.141.128.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 19:48:09 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2623.011; Thu, 9 Jan 2020
 19:48:08 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:208:134::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Thu, 9 Jan 2020 19:48:08 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1ipdmn-0005RS-8N; Thu, 09 Jan 2020 15:48:05 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v5 1/2] mm/mmu_notifier: make interval notifier updates
 safe
Thread-Topic: [PATCH v5 1/2] mm/mmu_notifier: make interval notifier updates
 safe
Thread-Index: AQHVtEsczeksfKC51EmFDx7aa5U3hKfi4tSA
Date:   Thu, 9 Jan 2020 19:48:08 +0000
Message-ID: <20200109194805.GK20978@mellanox.com>
References: <20191216195733.28353-1-rcampbell@nvidia.com>
 <20191216195733.28353-2-rcampbell@nvidia.com>
In-Reply-To: <20191216195733.28353-2-rcampbell@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR16CA0017.namprd16.prod.outlook.com
 (2603:10b6:208:134::30) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33a76dec-8581-4e2e-4e24-08d7953cd9eb
x-ms-traffictypediagnostic: VI1PR05MB6653:
x-microsoft-antispam-prvs: <VI1PR05MB665326EFA06D668DF6BCFEF1CF390@VI1PR05MB6653.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(199004)(189003)(66556008)(64756008)(66446008)(66476007)(478600001)(36756003)(2906002)(316002)(9786002)(9746002)(6916009)(81156014)(4326008)(66946007)(8676002)(7416002)(81166006)(52116002)(15650500001)(33656002)(1076003)(54906003)(8936002)(186003)(2616005)(5660300002)(86362001)(26005)(71200400001)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6653;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W7ZMJCrH3wKsDz9InIemDt7rsjyjV+fANE5RTvMLhMFbnJF5eNMNVJB5y2ovKbHL8HeRshVlC2U810C97Xjs2SfxMOYniSQkhNSgJi2HIZqGIRRSxG23rwOck7FOfXdeQoYL1kP46ZFjfkiu/bEhVyQ+myKYNcH8QWC9GJFlbo1Ej2kS9LRV6AbIQYoOJHPAFieBpcidPQBAI35w2INatsAhFwkRG08+knEoTwbllHSDWjRRf8rTfzUKPh6wRaNeybhuSlW/UDnjxQrL6mvRSaTlc/cYJT4d44u1kUiK60bECV16MLt8juvmTwXdexf91q8vbrlTWMY1/Iqs1P7Ay2rsxgU02I4qeevMyDgl0D3gQ28MTmD7AXcIIBZOr4woPpvSfQP/Y0VnSQJiNCtArhJ0PoC4uAKQSmAcWbBkFz/SpQn/q6HY/aR6HARWTt/pNB1ZBVYKmmcA/iaO/7igSWihETqkpkSgVbRiXjVSva4WVBezlg3ZeR4bTqlC+Uvl
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D0FB8002D432946B93B3D7EFF2A5461@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a76dec-8581-4e2e-4e24-08d7953cd9eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 19:48:08.6785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jllXwU4QtcgLhd4pWfrfuISZQCURFTMrs9v7IIDKewA03RhfZsiNO8K7cGkjvL2miAdkhUZtbH9bgGtL5yVVyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6653
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 16, 2019 at 11:57:32AM -0800, Ralph Campbell wrote:
> mmu_interval_notifier_insert() and mmu_interval_notifier_remove() can't
> be called safely from inside the invalidate() callback. This is fine for
> devices with explicit memory region register and unregister calls but it
> is desirable from a programming model standpoint to not require explicit
> memory region registration. Regions can be registered based on device
> address faults but without a mechanism for updating or removing the mmu
> interval notifiers in response to munmap(), the invalidation callbacks
> will be for regions that are stale or apply to different mmaped regions.
>=20
> The invalidate() callback provides the necessary information (i.e.,
> the event type MMU_NOTIFY_UNMAP) so add insert, remove, and update
> functions that are safe to call from the invalidate() callback by
> extending the work done in mn_itree_inv_end() to update the interval tree
> when it is not being traversed.
>=20
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>  include/linux/mmu_notifier.h |  15 +++
>  mm/mmu_notifier.c            | 196 ++++++++++++++++++++++++++++++-----
>  2 files changed, 186 insertions(+), 25 deletions(-)
>=20
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index 9e6caa8ecd19..55fbefcdc564 100644
> +++ b/include/linux/mmu_notifier.h
> @@ -233,11 +233,18 @@ struct mmu_notifier {
>   * @invalidate: Upon return the caller must stop using any SPTEs within =
this
>   *              range. This function can sleep. Return false only if sle=
eping
>   *              was required but mmu_notifier_range_blockable(range) is =
false.
> + * @release:	This function will be called when the mmu_interval_notifier
> + *		is removed from the interval tree. Defining this function also
> + *		allows mmu_interval_notifier_remove() and
> + *		mmu_interval_notifier_update() to be called from the
> + *		invalidate() callback function (i.e., they won't block waiting
> + *		for invalidations to finish.
>   */
>  struct mmu_interval_notifier_ops {
>  	bool (*invalidate)(struct mmu_interval_notifier *mni,
>  			   const struct mmu_notifier_range *range,
>  			   unsigned long cur_seq);
> +	void (*release)(struct mmu_interval_notifier *mni);
>  };
> =20
>  struct mmu_interval_notifier {
> @@ -246,6 +253,8 @@ struct mmu_interval_notifier {
>  	struct mm_struct *mm;
>  	struct hlist_node deferred_item;
>  	unsigned long invalidate_seq;
> +	unsigned long deferred_start;
> +	unsigned long deferred_last;
>  };
> =20
>  #ifdef CONFIG_MMU_NOTIFIER
> @@ -299,7 +308,13 @@ int mmu_interval_notifier_insert_locked(
>  	struct mmu_interval_notifier *mni, struct mm_struct *mm,
>  	unsigned long start, unsigned long length,
>  	const struct mmu_interval_notifier_ops *ops);
> +int mmu_interval_notifier_insert_safe(
> +	struct mmu_interval_notifier *mni, struct mm_struct *mm,
> +	unsigned long start, unsigned long length,
> +	const struct mmu_interval_notifier_ops *ops);
>  void mmu_interval_notifier_remove(struct mmu_interval_notifier *mni);
> +int mmu_interval_notifier_update(struct mmu_interval_notifier *mni,
> +				 unsigned long start, unsigned long length);
> =20
>  /**
>   * mmu_interval_set_seq - Save the invalidation sequence
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index f76ea05b1cb0..c303285750b2 100644
> +++ b/mm/mmu_notifier.c
> @@ -129,6 +129,7 @@ static void mn_itree_inv_end(struct mmu_notifier_mm *=
mmn_mm)
>  {
>  	struct mmu_interval_notifier *mni;
>  	struct hlist_node *next;
> +	struct hlist_head removed_list;
> =20
>  	spin_lock(&mmn_mm->lock);
>  	if (--mmn_mm->active_invalidate_ranges ||
> @@ -144,21 +145,47 @@ static void mn_itree_inv_end(struct mmu_notifier_mm=
 *mmn_mm)
>  	 * The inv_end incorporates a deferred mechanism like rtnl_unlock().
>  	 * Adds and removes are queued until the final inv_end happens then
>  	 * they are progressed. This arrangement for tree updates is used to
> -	 * avoid using a blocking lock during invalidate_range_start.
> +	 * avoid using a blocking lock while walking the interval tree.
>  	 */
> +	INIT_HLIST_HEAD(&removed_list);
>  	hlist_for_each_entry_safe(mni, next, &mmn_mm->deferred_list,
>  				  deferred_item) {
> +		hlist_del(&mni->deferred_item);
>  		if (RB_EMPTY_NODE(&mni->interval_tree.rb))
>  			interval_tree_insert(&mni->interval_tree,
>  					     &mmn_mm->itree);
> -		else
> +		else {
>  			interval_tree_remove(&mni->interval_tree,
>  					     &mmn_mm->itree);
> -		hlist_del(&mni->deferred_item);
> +			if (mni->deferred_last) {
> +				mni->interval_tree.start =3D mni->deferred_start;
> +				mni->interval_tree.last =3D mni->deferred_last;
> +				mni->deferred_last =3D 0;

Technicaly we can have an interval starting at zero.

I'd write it more like

if (mni->updated_start =3D=3D mni->updated_end)
    insert
else
    remove

ie an empty interval can't get a notification so it should be removed
from the tree.

I also like the name 'updated' better than deferred, it is a bit
clearer..

Adding release should it's own patch.

> @@ -970,14 +999,52 @@ int mmu_interval_notifier_insert_locked(
>  EXPORT_SYMBOL_GPL(mmu_interval_notifier_insert_locked);
> =20
>  /**
> - * mmu_interval_notifier_remove - Remove a interval notifier
> - * @mni: Interval notifier to unregister
> + * mmu_interval_notifier_insert_safe - Insert an interval notifier
> + * @mni: Interval notifier to register
> + * @mm : mm_struct to attach to
> + * @start: Starting virtual address to monitor
> + * @length: Length of the range to monitor
> + * @ops: Interval notifier callback operations
>   *
> - * This function must be paired with mmu_interval_notifier_insert(). It =
cannot
> - * be called from any ops callback.
> + * Return: -EINVAL if @mm hasn't been initialized for interval notifiers
> + *	by calling mmu_notifier_register(NULL, mm) or
> + *	__mmu_notifier_register(NULL, mm).
>   *
> - * Once this returns ops callbacks are no longer running on other CPUs a=
nd
> - * will not be called in future.
> + * This function subscribes the interval notifier for notifications from=
 the
> + * mm.  Upon return, the ops related to mmu_interval_notifier will be ca=
lled
> + * whenever an event that intersects with the given range occurs.
> + *
> + * This function is safe to call from the ops->invalidate() function.
> + * Upon return, the mmu_interval_notifier may not be present in the inte=
rval
> + * tree yet.  The caller must use the normal interval notifier read flow=
 via
> + * mmu_interval_read_begin() to establish SPTEs for this range.

So why do we need this? You can't call hmm_range_fault from a
notifier. You just can't.

So there should be no reason to create an interval from the notifier,
do it from where you call hmm_range_fault, and it must be safe to
obtain the mmap_sem from that thread.

> +/**
> + * mmu_interval_notifier_update - Update interval notifier end
> + * @mni: Interval notifier to update
> + * @start: New starting virtual address to monitor
> + * @length: New length of the range to monitor
> + *
> + * This function updates the range being monitored.
> + * If there is no release() function defined, the call will wait for the
> + * update to finish before returning.
> + */
> +int mmu_interval_notifier_update(struct mmu_interval_notifier *mni,
> +				 unsigned long start, unsigned long length)
> +{
> +	struct mm_struct *mm =3D mni->mm;
> +	struct mmu_notifier_mm *mmn_mm =3D mm->mmu_notifier_mm;
> +	unsigned long seq =3D 0;
> +	unsigned long last;
> +
> +	if (length =3D=3D 0 || check_add_overflow(start, length - 1, &last))
> +		return -EOVERFLOW;
> +
> +	spin_lock(&mmn_mm->lock);
> +	if (mn_itree_is_invalidating(mmn_mm)) {
> +		/*
> +		 * Update is being called after insert put this on the
> +		 * deferred list, but before the deferred list was processed.
> +		 */
> +		if (RB_EMPTY_NODE(&mni->interval_tree.rb)) {
> +			mni->interval_tree.start =3D start;
> +			mni->interval_tree.last =3D last;
> +		} else {
> +			if (!mni->deferred_last)
> +				hlist_add_head(&mni->deferred_item,
> +					       &mmn_mm->deferred_list);
> +			mni->deferred_start =3D start;
> +			mni->deferred_last =3D last;
> +		}
> +		seq =3D mmn_mm->invalidate_seq;
> +	} else {
> +		WARN_ON(RB_EMPTY_NODE(&mni->interval_tree.rb));
> +		interval_tree_remove(&mni->interval_tree, &mmn_mm->itree);
> +		mni->interval_tree.start =3D start;
> +		mni->interval_tree.last =3D last;
> +		interval_tree_insert(&mni->interval_tree, &mmn_mm->itree);
> +	}
> +	spin_unlock(&mmn_mm->lock);
> +
> +	if (!mni->ops->release && seq) {
> +		/*
> +		 * The possible sleep on progress in the invalidation requires
> +		 * the caller not hold any locks held by invalidation
> +		 * callbacks.
> +		 */
> +		lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
> +		lock_map_release(&__mmu_notifier_invalidate_range_start_map);
>  		wait_event(mmn_mm->wq,
>  			   READ_ONCE(mmn_mm->invalidate_seq) !=3D seq);
> +	}
> =20
> -	/* pairs with mmgrab in mmu_interval_notifier_insert() */
> -	mmdrop(mm);
> +	return 0;
>  }
> -EXPORT_SYMBOL_GPL(mmu_interval_notifier_remove);
> +EXPORT_SYMBOL_GPL(mmu_interval_notifier_update);

A 'update' should probably be the same as insert, it doesn't
necessarily take effect until mmu_interval_read_begin(), so nothing
contingent on release.

As before, I'm not sure what to do with this. We need an in-kernel
user for new apis, and I don't see a reason to make this more
complicated for a test program.=20

The test program should match one of the existing driver flows, so use
the page table like scheme from ODP or the fixed lifetime scheme from
AMDGPU/ODP

Jason
