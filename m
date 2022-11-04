Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9790C61A3DA
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 23:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKDWEw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 18:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiKDWEs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 18:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E799764FA
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Nov 2022 15:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667599433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4BKEW1vtM8NNbjWo0hdZBNH0W3ETngUyp+lvPMbVDv8=;
        b=HlfEl+AhK9UjL6IfxbfaEwqoZMQ7fvpDI50ThHTKi/sYyYR4WYE5W8MHel2p1d6rfxq9F7
        +MNfCdjvhvVktD6Ws9BX3UE/gRtuWvTHtOr1yq0PHYR2o3nxBHNKwogpSZ1Q675m1XzOoZ
        npXVV2tfy7F06DTaoWwt+AjOHkw112Y=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-502-btpiupcFO_-EVr9gdP9bjQ-1; Fri, 04 Nov 2022 18:03:52 -0400
X-MC-Unique: btpiupcFO_-EVr9gdP9bjQ-1
Received: by mail-il1-f200.google.com with SMTP id n7-20020a056e02148700b002ffbfe5a9aeso4666134ilk.19
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Nov 2022 15:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BKEW1vtM8NNbjWo0hdZBNH0W3ETngUyp+lvPMbVDv8=;
        b=GpC13l/Yp4bniGTZJniNXK6S4iYFUTEaNHVkUCx/UJTxy+WJiSqH6u2ledNK/xW73B
         Ajz/sIg5s/2gOe8YJsifLlfGF2Fec/HHkAFhMwuX4q9+8IXfmFh2/7wHWB8VLFPnth7r
         +U4ec6kph5xmdnJBj/76NLQgRkjKTqzaB5zZyEUbexF3noTCFtKLE1qYgnibAxOAtNOd
         +9e4J4dOqbTPhWaSTzr1wBtbBNDh3Y6vRS0jN7T0MwGgj0W6RvPwuapyHT4KPJYRkrkc
         x+ggDKjouQJ3/s1KB5Eg3/z4CGKZu8xaje4AMV4Ujfl2auOlb79uNGRMtdHFvbrgbyWK
         xMcw==
X-Gm-Message-State: ACrzQf3Sow/8gg4pblO0VfWh6tGfx5WfKBGB6rEW2fwV6tFNDgUgbL6e
        ADL5t8x/RBQ9+o+s+jihBzRV5vOK5SLd8qzHmYstB4lQWXSqbcMmgDbtDr2m9iEciR8zzCgHJ5N
        DhIXWntc0L5PyXQjTTFLJ0Km8kc3r
X-Received: by 2002:a05:6602:2d82:b0:6cc:ecf2:74f6 with SMTP id k2-20020a0566022d8200b006ccecf274f6mr22179699iow.103.1667599431280;
        Fri, 04 Nov 2022 15:03:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4BSIwnXgrh6WKIO+D6g0FMzzuLatSveMAp7xE1Q1wtwCSalcwPsKFPe4GaCpv4Kv1Id7VEmA==
X-Received: by 2002:a05:6602:2d82:b0:6cc:ecf2:74f6 with SMTP id k2-20020a0566022d8200b006ccecf274f6mr22179670iow.103.1667599430970;
        Fri, 04 Nov 2022 15:03:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id o6-20020a92c686000000b002ff5ac4fd1bsm224381ilg.54.2022.11.04.15.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 15:03:50 -0700 (PDT)
Date:   Fri, 4 Nov 2022 16:03:48 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 00/15] IOMMUFD Generic interface
Message-ID: <20221104160348.07aed446.alex.williamson@redhat.com>
In-Reply-To: <20221104152713.3ae1c409.alex.williamson@redhat.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
        <20221104152713.3ae1c409.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 4 Nov 2022 15:27:13 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 25 Oct 2022 15:12:09 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > [
> > At this point everything is done and I will start putting this work into a
> > git tree and into linux-next with the intention of sending it during the
> > next merge window.
> > 
> > I intend to focus the next several weeks on more intensive QA to look at
> > error flows and other things. Hopefully including syzkaller if I'm lucky
> > ]  
> 
> In case this one hasn't been reported yet (with IOMMUFD_VFIO_CONTAINER):

And...

------------[ cut here ]------------
WARNING: CPU: 4 PID: 1736 at drivers/iommu/iommufd/io_pagetable.c:660 iopt_destroy_table+0x91/0xc0 [iommufd]
Modules linked in: scsi_transport_iscsi(E) xt_CHECKSUM(E) xt_MASQUERADE(E) xt_conntrack(E) ipt_REJECT(E) nf_nat_tftp(E) nft_objref(E) nf_conntrack_tftp(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_tables(E) bridge(E) stp(E) llc(E) ebtable_nat(E) ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E) ip6table_raw(E) ip6table_security(E) iptable_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) iptable_mangle(E) iptable_raw(E) iptable_security(E) ip_set(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) iptable_filter(E) sunrpc(E) intel_rapl_msr(E) intel_rapl_common(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) snd_hda_intel(E) snd_intel_dspcfg(E) kvm_intel(E) snd_hda_codec(E) snd_hwdep(E) bcache(E) iTCO_wdt(E) snd_hda_core(E) kvm(E) mei_hdcp(E) intel_pmc_bxt(E) at24(E) snd_seq(E) iTCO_vendor_support(E)
 eeepc_wmi(E) snd_seq_device(E) asus_wmi(E) rapl(E) snd_pcm(E) ledtrig_audio(E) intel_cstate(E) sparse_keymap(E) intel_uncore(E) mei_me(E) snd_timer(E) platform_profile(E) i2c_i801(E) rfkill(E) wmi_bmof(E) snd(E) i2c_smbus(E) soundcore(E) mei(E) lpc_ich(E) ip_tables(E) i915(E) crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) ghash_clmulni_intel(E) vfio_pci(E) vfio_pci_core(E) irqbypass(E) vfio_virqfd(E) serio_raw(E) i2c_algo_bit(E) drm_buddy(E) drm_display_helper(E) drm_kms_helper(E) cec(E) ttm(E) r8169(E) e1000e(E) drm(E) video(E) wmi(E) mtty(E) mdev(E) vfio(E) iommufd(E) macvtap(E) macvlan(E) tap(E)
CPU: 4 PID: 1736 Comm: qemu-system-x86 Tainted: G            E      6.1.0-rc3+ #133
Hardware name: System manufacturer System Product Name/P8H67-M PRO, BIOS 3904 04/27/2013
RIP: 0010:iopt_destroy_table+0x91/0xc0 [iommufd]
Code: a8 01 00 00 48 85 c0 75 21 49 83 bc 24 e0 00 00 00 00 75 23 49 8b 84 24 88 01 00 00 48 85 c0 75 25 5b 5d 41 5c c3 cc cc cc cc <0f> 0b 49 83 bc 24 e0 00 00 00 00 74 dd 0f 0b 49 8b 84 24 88 01 00
RSP: 0018:ffff9c8dc1c63cb0 EFLAGS: 00010282
RAX: ffff90d454863a80 RBX: ffff90d3f5fe3e40 RCX: 0000000000000000
RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff90d3f5fe3e40
RBP: 0000000000000000 R08: 0000000000000001 R09: ffff90d43234b240
R10: 0000000000000000 R11: ffff90d42c703000 R12: ffff90d3f5fe3ca8
R13: 0000000000000001 R14: ffff90d43ca32138 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff90d7df700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3fba3c6000 CR3: 000000009ba26005 CR4: 00000000001726e0
Call Trace:
 <TASK>
 iommufd_ioas_destroy+0x2b/0x60 [iommufd]
 iommufd_fops_release+0x8b/0xe0 [iommufd]
 __fput+0x94/0x250
 task_work_run+0x59/0x90
 do_exit+0x374/0xbd0
 ? rcu_read_lock_sched_held+0x12/0x70
 do_group_exit+0x33/0xa0
 get_signal+0xaf4/0xb20
 arch_do_signal_or_restart+0x36/0x780
 ? do_futex+0x126/0x1c0
 exit_to_user_mode_prepare+0x181/0x260
 syscall_exit_to_user_mode+0x16/0x50
 do_syscall_64+0x48/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd1ef7a3750
Code: Unable to access opcode bytes at 0x7fd1ef7a3726.
RSP: 002b:00007fd1e21fb5d8 EFLAGS: 00000282 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 00007fd1ef7a3750
RDX: 0000000000000002 RSI: 0000000000000080 RDI: 00005571b8cf38c0
RBP: 00007fd1e21fb630 R08: 0000000000000000 R09: 000000000000000b
R10: 0000000000000000 R11: 0000000000000282 R12: 00007ffd9787d1ae
R13: 00007ffd9787d1af R14: 00007ffd9787d270 R15: 00007fd1e2200700
 </TASK>
irq event stamp: 202
hardirqs last  enabled at (201): [<ffffffffa7e235a2>] syscall_enter_from_user_mode+0x22/0xb0
hardirqs last disabled at (202): [<ffffffffa7e2da5d>] __schedule+0x7ed/0xd30
softirqs last  enabled at (0): [<ffffffffa70e2241>] copy_process+0x9f1/0x1e90
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---

