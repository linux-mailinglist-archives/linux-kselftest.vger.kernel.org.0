Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9439C18C360
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Mar 2020 23:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgCSW4z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Mar 2020 18:56:55 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16127 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCSW4z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Mar 2020 18:56:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e73f8a80000>; Thu, 19 Mar 2020 15:56:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 19 Mar 2020 15:56:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 19 Mar 2020 15:56:53 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Mar
 2020 22:56:52 +0000
Subject: Re: [PATCH 3/4] mm: simplify device private page handling in
 hmm_range_fault
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>, <kvm-ppc@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <nouveau@lists.freedesktop.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
References: <20200316193216.920734-1-hch@lst.de>
 <20200316193216.920734-4-hch@lst.de>
 <7256f88d-809e-4aba-3c46-a223bd8cc521@nvidia.com>
 <20200317121536.GQ20941@ziepe.ca> <20200317122445.GA11662@lst.de>
 <20200317122813.GA11866@lst.de> <20200317124755.GR20941@ziepe.ca>
 <20200317125955.GA12847@lst.de>
 <24fca825-3b0f-188f-bcf2-fadcf3a9f05a@nvidia.com>
 <20200319181716.GK20941@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <89e33770-a0ab-e1ec-d5e5-535edefd3fd3@nvidia.com>
Date:   Thu, 19 Mar 2020 15:56:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200319181716.GK20941@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584658600; bh=jWtYAqOwm8Is3zfNg8T2VUHSQAGEqH4bFJvlP/cbAdI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=L3MldKoLb909Swj7le7BsPWM7W3wCPpqBfO75tYkz1+3aY+gwrDTpWPV9/BIdjVPP
         pDEzmgs8Xhr2NknjBndQI6t7WvVH2wR+AmNP64NVlZtuwhk/ZA+02d7YC/MZnlhHVx
         f4yzL44qRt1nHIOL4x3hlnC+q9xO7FVsICjeb+JZ+4NYnkWoSGUvVojDZogrUMmcqW
         sOqshFPd2dtO3QVv+8PaoNBXQJGCfgJ1qcA/f46dca/2qWJnEu8KxnHPPXOnbW+lVe
         JHM+6NPibxOMeicwFjnfrrhrzOFNFdxzl4UbFuxSWOerjmWAIHl4faVbN20E9Ycrhl
         +ww/Q/4iWkKLQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adding linux-kselftest@vger.kernel.org for the test config question.

On 3/19/20 11:17 AM, Jason Gunthorpe wrote:
> On Tue, Mar 17, 2020 at 04:14:31PM -0700, Ralph Campbell wrote:
>>
>> On 3/17/20 5:59 AM, Christoph Hellwig wrote:
>>> On Tue, Mar 17, 2020 at 09:47:55AM -0300, Jason Gunthorpe wrote:
>>>> I've been using v7 of Ralph's tester and it is working well - it has
>>>> DEVICE_PRIVATE support so I think it can test this flow too. Ralph are
>>>> you able?
>>>>
>>>> This hunk seems trivial enough to me, can we include it now?
>>>
>>> I can send a separate patch for it once the tester covers it.  I don't
>>> want to add it to the original patch as it is a significant behavior
>>> change compared to the existing code.
>>>
>>
>> Attached is an updated version of my HMM tests based on linux-5.6.0-rc6.
>> I ran this OK with Jason's 8+1 HMM patches, Christoph's 1-5 misc HMM cle=
an ups,
>> and Christoph's 1-4 device private page changes applied.
>=20
> I'd like to get this to mergable, it looks pretty good now, but I have
> no idea about selftests - and I'm struggling to even compile the tools
> dir
>=20
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 69def4a9df00..4d22ce7879a7 100644
>> +++ b/lib/Kconfig.debug
>> @@ -2162,6 +2162,18 @@ config TEST_MEMINIT
>>  =20
>>   	  If unsure, say N.
>>  =20
>> +config TEST_HMM
>> +	tristate "Test HMM (Heterogeneous Memory Management)"
>> +	depends on DEVICE_PRIVATE
>> +	select HMM_MIRROR
>> +        select MMU_NOTIFIER
>=20
> extra spaces

Will fix in v8.

> In general I wonder if it even makes sense that DEVICE_PRIVATE is user
> selectable?

Should tests enable the feature or the feature enable the test?
IMHO, if the feature is being compiled into the kernel, that should
enable the menu item for the test. If the feature isn't selected,
no need to test it :-)

>> +static int dmirror_fops_open(struct inode *inode, struct file *filp)
>> +{
>> +	struct cdev *cdev =3D inode->i_cdev;
>> +	struct dmirror *dmirror;
>> +	int ret;
>> +
>> +	/* Mirror this process address space */
>> +	dmirror =3D kzalloc(sizeof(*dmirror), GFP_KERNEL);
>> +	if (dmirror =3D=3D NULL)
>> +		return -ENOMEM;
>> +
>> +	dmirror->mdevice =3D container_of(cdev, struct dmirror_device, cdevice=
);
>> +	mutex_init(&dmirror->mutex);
>> +	xa_init(&dmirror->pt);
>> +
>> +	ret =3D mmu_interval_notifier_insert(&dmirror->notifier, current->mm,
>> +				0, ULONG_MAX & PAGE_MASK, &dmirror_min_ops);
>> +	if (ret) {
>> +		kfree(dmirror);
>> +		return ret;
>> +	}
>> +
>> +	/* Pairs with the mmdrop() in dmirror_fops_release(). */
>> +	mmgrab(current->mm);
>> +	dmirror->mm =3D current->mm;
>=20
> The notifier holds a mmgrab, no need for another one

OK. I'll replace dmirror->mm with dmirror->notifier.mm.

>> +	/* Only the first open registers the address space. */
>> +	filp->private_data =3D dmirror;
>=20
> Not sure what this comment means

I'll change the comment to:
	/*
          * The first open of the device character file registers the addre=
ss
          * space of the process doing the open() system call with the devi=
ce.
          * Subsequent file opens by other processes will have access to th=
e
          * first process' address space.
          */

>> +static inline struct dmirror_device *dmirror_page_to_device(struct page=
 *page)
>> +
>> +{
>> +	struct dmirror_chunk *devmem;
>> +
>> +	devmem =3D container_of(page->pgmap, struct dmirror_chunk, pagemap);
>> +	return devmem->mdevice;
>> +}
>=20
> extra devmem var is not really needed

I'll change this to:
	return container_of(page->pgmap, struct dmirror_chunk,
			    pagemap)->mdevice;

>> +
>> +static bool dmirror_device_is_mine(struct dmirror_device *mdevice,
>> +				   struct page *page)
>> +{
>> +	if (!is_zone_device_page(page))
>> +		return false;
>> +	return page->pgmap->ops =3D=3D &dmirror_devmem_ops &&
>> +		dmirror_page_to_device(page) =3D=3D mdevice;
>> +}
>=20
> Use new owner stuff, right? Actually this is redunant now, the check
> should be just WARN_ON pageowner !=3D self owner

I'll clean this up. dmirror_device_is_mine() isn't needed now.

>> +static int dmirror_do_fault(struct dmirror *dmirror, struct hmm_range *=
range)
>> +{
>> +	uint64_t *pfns =3D range->pfns;
>> +	unsigned long pfn;
>> +
>> +	for (pfn =3D (range->start >> PAGE_SHIFT);
>> +	     pfn < (range->end >> PAGE_SHIFT);
>> +	     pfn++, pfns++) {
>> +		struct page *page;
>> +		void *entry;
>> +
>> +		/*
>> +		 * HMM_PFN_ERROR is returned if it is accessing invalid memory
>> +		 * either because of memory error (hardware detected memory
>> +		 * corruption) or more likely because of truncate on mmap
>> +		 * file.
>> +		 */
>> +		if (*pfns =3D=3D range->values[HMM_PFN_ERROR])
>> +			return -EFAULT;
>=20
> Unless that snapshot is use hmm_range_fault() never returns success
> and sets PFN_ERROR, so this should be a WARN_ON
>=20
>> +		if (!(*pfns & range->flags[HMM_PFN_VALID]))
>> +			return -EFAULT;
>=20
> Same with valid.
>=20
>> +		page =3D hmm_device_entry_to_page(range, *pfns);
>> +		/* We asked for pages to be populated but check anyway. */
>> +		if (!page)
>> +			return -EFAULT;
>=20
> WARN_ON
>=20
>> +		if (is_zone_device_page(page)) {
>> +			/*
>> +			 * TODO: need a way to ask HMM to fault foreign zone
>> +			 * device private pages.
>> +			 */
>> +			if (!dmirror_device_is_mine(dmirror->mdevice, page))
>> +				continue;
>=20
> Actually re
>=20
>> +static bool dmirror_interval_invalidate(struct mmu_interval_notifier *m=
ni,
>> +				const struct mmu_notifier_range *range,
>> +				unsigned long cur_seq)
>> +{
>> +	struct dmirror *dmirror =3D container_of(mni, struct dmirror, notifier=
);
>> +	struct mm_struct *mm =3D dmirror->mm;
>> +
>> +	/*
>> +	 * If the process doesn't exist, we don't need to invalidate the
>> +	 * device page table since the address space will be torn down.
>> +	 */
>> +	if (!mmget_not_zero(mm))
>> +		return true;
>=20
> Why? Don't the notifiers provide for this already.
>=20
> mmget_not_zero() is required before calling hmm_range_fault() though

This is a workaround for a problem I don't quite understand.
If you change tools/testing/selftests/vm/hmm-tests.c line 868 to
	ASSERT_EQ(ret, -1);
Then the test will abort, core dump, and cause two problems,
1) the migrated page will be faulted back to system memory in order to writ=
e
    it to the core dump. This triggers lockdep_assert_held(&walk.mm->mmap_s=
em)
    in walk_page_range().
2) Then after a delay, I get:
[  137.852986] rcu: INFO: rcu_sched self-detected stall on CPU
[  137.858594] rcu: 	0-....: (26000 ticks this GP) idle=3D69e/1/0x400000000=
0000002 softirq=3D34555/34555 fqs=3D6497
[  137.868439] 	(t=3D26007 jiffies g=3D14653 q=3D271)
[  137.872711] NMI backtrace for cpu 0
[  137.876205] CPU: 0 PID: 6228 Comm: hmm-tests Not tainted 5.6.0-rc6+ #2
[  137.882730] Hardware name: System manufacturer System Product Name/SABER=
TOOTH X79, BIOS 4302 08/29/2013
[  137.892115] Call Trace:
[  137.894570]  <IRQ>
[  137.896593]  dump_stack+0x97/0xe0
[  137.899920]  nmi_cpu_backtrace.cold+0x14/0x68
[  137.904287]  ? lapic_can_unplug_cpu.cold+0x39/0x39
[  137.909091]  nmi_trigger_cpumask_backtrace+0xf1/0x10e
[  137.914152]  rcu_dump_cpu_stacks+0xe2/0x125
[  137.918348]  rcu_sched_clock_irq.cold+0x393/0x610
[  137.923069]  update_process_times+0x24/0x50
[  137.927263]  tick_sched_handle+0x68/0x90
[  137.931196]  tick_sched_timer+0x38/0xa0
[  137.935037]  __hrtimer_run_queues+0x1f9/0x6c0
[  137.939403]  ? tick_sched_do_timer+0x90/0x90
[  137.943683]  ? enqueue_hrtimer+0x1a0/0x1a0
[  137.947790]  ? recalibrate_cpu_khz+0x10/0x10
[  137.952064]  ? ktime_get_update_offsets_now+0xed/0x1c0
[  137.957209]  hrtimer_interrupt+0x1a5/0x340
[  137.961315]  ? rcu_read_lock_sched_held+0xa1/0xd0
[  137.966038]  smp_apic_timer_interrupt+0xbb/0x320
[  137.970665]  apic_timer_interrupt+0xf/0x20
[  137.974771]  </IRQ>
[  137.976876] RIP: 0010:xas_load+0x7/0x80
[  137.980718] Code: 80 2f 1a 83 c6 05 e9 8d 7b 01 01 e8 3e b1 b1 fe e9 05 =
ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 41 56 41 55 41 54 55 <48=
> 89 fd 53 4c 8d 6d 10 e8 3c fc ff ff 49 89 c4 4c 89 e0 83 e0 03
[  137.999461] RSP: 0018:ffffc900015e77c8 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[  138.007028] RAX: ffff8886e508c408 RBX: 0000000000000000 RCX: ffffffff826=
26c89
[  138.014159] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffffc900015=
e78a0
[  138.021293] RBP: ffffc900015e78a0 R08: ffffffff811461c4 R09: fffff520002=
bcf17
[  138.028426] R10: fffff520002bcf16 R11: 0000000000000003 R12: 00000000026=
06d10
[  138.035557] R13: ffff8886e508c448 R14: 0000000000000031 R15: ffffffffa06=
546a0
[  138.042701]  ? do_raw_spin_lock+0x104/0x1d0
[  138.046888]  ? xas_store+0x19/0xa60
[  138.050390]  xas_store+0x5b3/0xa60
[  138.053806]  ? register_lock_class+0x860/0x860
[  138.058267]  __xa_erase+0x96/0x110
[  138.061673]  ? xas_store+0xa60/0xa60
[  138.065267]  xa_erase+0x19/0x30
[  138.068418]  dmirror_interval_invalidate+0x7d/0xc0 [test_hmm]
[  138.074174]  __mmu_notifier_release+0x1a6/0x370
[  138.078714]  ? mmu_notifier_unregister+0x1e0/0x1e0
[  138.083520]  ? lock_downgrade+0x380/0x380
[  138.087535]  ? uprobe_clear_state+0x2e/0x150
[  138.091823]  exit_mmap+0x24d/0x2a0
[  138.095229]  ? do_munmap+0x10/0x10
[  138.098635]  ? __x64_sys_io_setup+0x200/0x200
[  138.102995]  ? __mutex_unlock_slowpath+0xb4/0x3f0
[  138.107704]  ? wait_for_completion+0x250/0x250
[  138.112158]  ? lock_downgrade+0x380/0x380
[  138.116176]  ? check_flags.part.0+0x82/0x210
[  138.120463]  mmput+0xb5/0x210
[  138.123444]  do_exit+0x602/0x14c0
[  138.126776]  ? mm_update_next_owner+0x400/0x400
[  138.131329]  do_group_exit+0x8a/0x140
[  138.135006]  get_signal+0x25b/0x1080
[  138.138606]  do_signal+0x8c/0xa90
[  138.141928]  ? _raw_spin_unlock_irq+0x24/0x30
[  138.146292]  ? mark_held_locks+0x24/0x90
[  138.150219]  ? _raw_spin_unlock_irq+0x24/0x30
[  138.154580]  ? lockdep_hardirqs_on+0x190/0x280
[  138.159026]  ? setup_sigcontext+0x260/0x260
[  138.163210]  ? sigprocmask+0x10b/0x150
[  138.166965]  ? __x64_sys_rt_sigsuspend+0xe0/0xe0
[  138.171594]  ? __x64_sys_rt_sigprocmask+0xfb/0x180
[  138.176394]  ? __ia32_compat_sys_rt_sigprocmask+0x190/0x190
[  138.181965]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
[  138.187192]  ? exit_to_usermode_loop+0x60/0x100
[  138.191723]  ? mark_held_locks+0x24/0x90
[  138.195656]  exit_to_usermode_loop+0x85/0x100
[  138.200023]  do_syscall_64+0x20b/0x290
[  138.203782]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  138.208839] RIP: 0033:0x7f2d349f1625
[  138.212420] Code: c2 b8 ea 00 00 00 0f 05 48 3d 00 f0 ff ff 77 3d 41 89 =
c0 41 ba 08 00 00 00 31 d2 4c 89 ce bf 02 00 00 00 b8 0e 00 00 00 0f 05 <48=
> 8b 84 24 08 01 00 00 64 48 33 04 25 28 00 00 00 75 24 44 89 c0
[  138.231163] RSP: 002b:00007ffe84228c60 EFLAGS: 00000246 ORIG_RAX: 000000=
000000000e
[  138.238731] RAX: 0000000000000000 RBX: 00007f2d349ad040 RCX: 00007f2d349=
f1625
[  138.245862] RDX: 0000000000000000 RSI: 00007ffe84228c60 RDI: 00000000000=
00002
[  138.252997] RBP: 00007ffe84228ec0 R08: 0000000000000000 R09: 00007ffe842=
28c60
[  138.260127] R10: 0000000000000008 R11: 0000000000000246 R12: 00000000004=
01240
[  138.267261] R13: 00007ffe84229190 R14: 0000000000000000 R15: 00000000000=
00000
[  138.274554] rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks=
: { 0-... } 26428 jiffies s: 277 root: 0x1/.
[  138.285167] rcu: blocking rcu_node structures:
[  138.289641] Task dump for CPU 0:
[  138.292890] hmm-tests       R  running task    27560  6228   6211 0x8000=
400a
[  138.300002] Call Trace:
[  138.302486]  ? check_chain_key+0x1d1/0x2c0
[  138.306627]  ? __lock_acquire+0x61c/0x2820
[  138.310760]  ? match_held_lock+0x1b/0x230
[  138.314800]  ? check_chain_key+0x1d1/0x2c0
[  138.318937]  ? lock_downgrade+0x380/0x380
[  138.323008]  ? lock_acquire+0xff/0x220
[  138.326795]  ? stack_depot_save+0x137/0x450
[  138.331026]  ? _raw_spin_unlock_irqrestore+0x3e/0x50
[  138.336026]  ? mark_held_locks+0x24/0x90
[  138.340012]  ? _raw_spin_unlock_irqrestore+0x3e/0x50
[  138.345022]  ? lockdep_hardirqs_on+0x190/0x280
[  138.349504]  ? stack_depot_save+0x253/0x450
[  138.353731]  ? check_chain_key+0x1d1/0x2c0
[  138.357871]  ? __lock_acquire+0x61c/0x2820
[  138.362033]  ? match_held_lock+0x1b/0x230
[  138.366070]  ? check_chain_key+0x1d1/0x2c0
[  138.370209]  ? mark_lock+0xac/0x9e0
[  138.373734]  ? mark_lock+0xac/0x9e0
[  138.377261]  ? mark_lock+0xac/0x9e0
[  138.380772]  ? mark_held_locks+0x65/0x90
[  138.384730]  ? mark_lock+0xac/0x9e0
[  138.388249]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  138.392895]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  138.397542]  ? lockdep_hardirqs_on+0x190/0x280
[  138.402029]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  138.406676]  ? mark_lock+0xac/0x9e0
[  138.410209]  ? lock_is_held_type+0x110/0x140
[  138.414509]  ? mark_held_locks+0x65/0x90
[  138.418461]  ? match_held_lock+0x1b/0x230
[  138.422500]  ? match_held_lock+0x1b/0x230
[  138.426551]  ? __lock_acquire+0x11c3/0x2820
[  138.430773]  ? xas_load+0x64/0x80
[  138.434126]  ? xas_store+0xac/0xa60
[  138.437652]  ? register_lock_class+0x860/0x860
[  138.442140]  ? lock_downgrade+0x380/0x380
[  138.446193]  ? _raw_spin_lock+0x2c/0x40
[  138.450059]  ? _raw_spin_unlock+0x17/0x30
[  138.454100]  ? xa_erase+0xe/0x30
[  138.457370]  ? dmirror_interval_invalidate+0x7d/0xc0 [test_hmm]
[  138.463325]  ? __mmu_notifier_release+0x1a6/0x370
[  138.468065]  ? mmu_notifier_unregister+0x1e0/0x1e0
[  138.472896]  ? lock_downgrade+0x380/0x380
[  138.476937]  ? uprobe_clear_state+0x2e/0x150
[  138.481252]  ? exit_mmap+0x24d/0x2a0
[  138.484859]  ? do_munmap+0x10/0x10
[  138.488298]  ? __x64_sys_io_setup+0x200/0x200
[  138.492683]  ? __mutex_unlock_slowpath+0xb4/0x3f0
[  138.497418]  ? wait_for_completion+0x250/0x250
[  138.501897]  ? lock_downgrade+0x380/0x380
[  138.505944]  ? check_flags.part.0+0x82/0x210
[  138.510254]  ? mmput+0xb5/0x210
[  138.513435]  ? do_exit+0x602/0x14c0
[  138.516967]  ? mm_update_next_owner+0x400/0x400
[  138.521545]  ? do_group_exit+0x8a/0x140
[  138.525423]  ? get_signal+0x25b/0x1080
[  138.529225]  ? do_signal+0x8c/0xa90
[  138.532755]  ? _raw_spin_unlock_irq+0x24/0x30
[  138.537143]  ? mark_held_locks+0x24/0x90
[  138.541096]  ? _raw_spin_unlock_irq+0x24/0x30
[  138.545492]  ? lockdep_hardirqs_on+0x190/0x280
[  138.549971]  ? setup_sigcontext+0x260/0x260
[  138.554190]  ? sigprocmask+0x10b/0x150
[  138.557969]  ? __x64_sys_rt_sigsuspend+0xe0/0xe0
[  138.562627]  ? __x64_sys_rt_sigprocmask+0xfb/0x180
[  138.567452]  ? __ia32_compat_sys_rt_sigprocmask+0x190/0x190
[  138.573057]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
[  138.578311]  ? exit_to_usermode_loop+0x60/0x100
[  138.582875]  ? mark_held_locks+0x24/0x90
[  138.586837]  ? exit_to_usermode_loop+0x85/0x100
[  138.591400]  ? do_syscall_64+0x20b/0x290
[  138.595360]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
./test_hmm.sh: line 58:  6211 Alarm clock             ./hmm-tests


>> +static int dmirror_fault(struct dmirror *dmirror, unsigned long start,
>> +			 unsigned long end, bool write)
>> +{
>> +	struct mm_struct *mm =3D dmirror->mm;
>> +	unsigned long addr;
>> +	uint64_t pfns[64];
>> +	struct hmm_range range =3D {
>> +		.notifier =3D &dmirror->notifier,
>> +		.pfns =3D pfns,
>> +		.flags =3D dmirror_hmm_flags,
>> +		.values =3D dmirror_hmm_values,
>> +		.pfn_shift =3D DPT_SHIFT,
>> +		.pfn_flags_mask =3D ~(dmirror_hmm_flags[HMM_PFN_VALID] |
>> +				    dmirror_hmm_flags[HMM_PFN_WRITE]),
>> +		.default_flags =3D dmirror_hmm_flags[HMM_PFN_VALID] |
>> +				(write ? dmirror_hmm_flags[HMM_PFN_WRITE] : 0),
>> +		.dev_private_owner =3D dmirror->mdevice,
>> +	};
>> +	int ret =3D 0;
>> +
>> +	/* Since the mm is for the mirrored process, get a reference first. */
>> +	if (!mmget_not_zero(mm))
>> +		return 0;
>=20
> Right
>=20
>> +	for (addr =3D start; addr < end; addr =3D range.end) {
>> +		range.start =3D addr;
>> +		range.end =3D min(addr + (ARRAY_SIZE(pfns) << PAGE_SHIFT), end);
>> +
>> +		ret =3D dmirror_range_fault(dmirror, &range);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +	mmput(mm);
>> +	return ret;
>> +}
>> +
>> +static int dmirror_do_read(struct dmirror *dmirror, unsigned long start=
,
>> +			   unsigned long end, struct dmirror_bounce *bounce)
>> +{
>> +	unsigned long pfn;
>> +	void *ptr;
>> +
>> +	ptr =3D bounce->ptr + ((start - bounce->addr) & PAGE_MASK);
>> +
>> +	for (pfn =3D start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++) {
>> +		void *entry;
>> +		struct page *page;
>> +		void *tmp;
>> +
>> +		entry =3D xa_load(&dmirror->pt, pfn);
>> +		page =3D xa_untag_pointer(entry);
>> +		if (!page)
>> +			return -ENOENT;
>> +
>> +		tmp =3D kmap(page);
>> +		memcpy(ptr, tmp, PAGE_SIZE);
>> +		kunmap(page);
>> +
>> +		ptr +=3D PAGE_SIZE;
>> +		bounce->cpages++;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int dmirror_read(struct dmirror *dmirror, struct hmm_dmirror_cmd=
 *cmd)
>> +{
>> +	struct dmirror_bounce bounce;
>> +	unsigned long start, end;
>> +	unsigned long size =3D cmd->npages << PAGE_SHIFT;
>> +	int ret;
>> +
>> +	start =3D cmd->addr;
>> +	end =3D start + size;
>> +	if (end < start)
>> +		return -EINVAL;
>> +
>> +	ret =3D dmirror_bounce_init(&bounce, start, size);
>> +	if (ret)
>> +		return ret;
>> +
>> +again:
>> +	mutex_lock(&dmirror->mutex);
>> +	ret =3D dmirror_do_read(dmirror, start, end, &bounce);
>> +	mutex_unlock(&dmirror->mutex);
>> +	if (ret =3D=3D 0)
>> +		ret =3D copy_to_user((void __user *)cmd->ptr, bounce.ptr,
>> +					bounce.size);
>=20
> Use u64_to_user_ptr() instead of the cast

Will do.

>> +static int dmirror_write(struct dmirror *dmirror, struct hmm_dmirror_cm=
d *cmd)
>> +{
>> +	struct dmirror_bounce bounce;
>> +	unsigned long start, end;
>> +	unsigned long size =3D cmd->npages << PAGE_SHIFT;
>> +	int ret;
>> +
>> +	start =3D cmd->addr;
>> +	end =3D start + size;
>> +	if (end < start)
>> +		return -EINVAL;
>> +
>> +	ret =3D dmirror_bounce_init(&bounce, start, size);
>> +	if (ret)
>> +		return ret;
>> +	ret =3D copy_from_user(bounce.ptr, (void __user *)cmd->ptr,
>> +				bounce.size);
>=20
> ditto
>=20
>> +	if (ret)
>> +		return ret;
>> +
>> +again:
>> +	mutex_lock(&dmirror->mutex);
>> +	ret =3D dmirror_do_write(dmirror, start, end, &bounce);
>> +	mutex_unlock(&dmirror->mutex);
>> +	if (ret =3D=3D -ENOENT) {
>> +		start =3D cmd->addr + (bounce.cpages << PAGE_SHIFT);
>> +		ret =3D dmirror_fault(dmirror, start, end, true);
>> +		if (ret =3D=3D 0) {
>> +			cmd->faults++;
>> +			goto again;
>=20
> Use a loop instead of goto?

OK.

> Also I get this:
>=20
> lib/test_hmm.c: In function =E2=80=98dmirror_devmem_fault_alloc_and_copy=
=E2=80=99:
> lib/test_hmm.c:1041:25: warning: unused variable =E2=80=98vma=E2=80=99 [-=
Wunused-variable]
>   1041 |  struct vm_area_struct *vma =3D args->vma;
>=20
> But this is a kernel bug, due to alloc_page_vma being a #define not a
> static inline and me having CONFIG_NUMA off in this .config

Fixed.
I'll repost as a proper series shortly.

> Jason
>=20
