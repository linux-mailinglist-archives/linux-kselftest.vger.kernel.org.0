Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BE36C4FB2
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 16:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCVPtV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 11:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCVPtU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 11:49:20 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DDC40FB;
        Wed, 22 Mar 2023 08:49:18 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id ga7so4354013qtb.2;
        Wed, 22 Mar 2023 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679500157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxCo/emcTRydvMAA53ojwX0TrlpJeTH34Joj3/xDCC8=;
        b=XG2UPBpnGN3RPeaIfmdhALznDUKbg3XRzFGTT80p5yf1CLxKY9jXtF+dooeXuQgal2
         TEVJ/jy/GRUwu67FgqLd/Lvhl97VgbI8lLvXO0OEw7vpwxbpN9NATlYZ1eAVJbO15xVq
         dnipiQ/+OJP6KP1jFMNKh+JuTUBltoiFX7n0rhdBO0gajQrPK0j5hPWyVlKhC2TzaVYW
         2wcE8EYz2nYKEqOcucSOmnY82DTm0ozQ8q7/Fdl+fQBst1sloyD1D/3oFNSrCsD7j1YK
         ht+i1RnCYc79u/pk5QJoldRK1YDjF50L6bM30/hrJenXSzv59PVc0ML9Vkk9nelM4OW+
         /Sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679500157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxCo/emcTRydvMAA53ojwX0TrlpJeTH34Joj3/xDCC8=;
        b=j3vDRmkwJZZlLZOIZF5Bz39ONcD1PQAVdH+MUIf8t1GLqhiVtq6tArcVD1H5M38dgk
         cTPKbf19jql8tDVJFOfWNL8hlgCEquif/n+UFnaSPaonnM6ivBd7CnISdTafkQ6cq7mC
         cW3PaDmAA/QGBTNrJssEDBSkzpiNeVxZqSRyGTAQ1PSeArLv16yahL96+aiWX7Ft2gDJ
         yZ8fvMXZKEhzKDLDBDnUdn7Mb7ARBV6Q5RQzXom4hnT9dik2nJUiZKLc8/D+yUE+w1Jr
         TWhEA8qF9FCuDMHe+lgc4RIQU4w9j3ksUHSn6JNgfnS0y2LGpGfmRNeqWYSu2NX60oZu
         NoyA==
X-Gm-Message-State: AO0yUKWF0xlWlQfglcmEMLtmqZXjFBC7Lcuy/nd8cSL84iVuIyFS7dX8
        chrjyQ+u6GD4g9jJSGLcmg5OgfApsnLqZh4VKFy1VjYw7Ym09w==
X-Google-Smtp-Source: AK7set8VNuMQo62e89QV4u8aTwXo54MyT9OCUAQQItOaezno/IbsMbcdy/VqsEck9EuXMSVLZrxHVSmgS2KfGiqz+1c=
X-Received: by 2002:ac8:5a84:0:b0:3d7:9d03:75b0 with SMTP id
 c4-20020ac85a84000000b003d79d0375b0mr1637369qtc.13.1679500157176; Wed, 22 Mar
 2023 08:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
 <167380336323.10651.16305246945409527645.stgit@bazille.1015granger.net>
In-Reply-To: <167380336323.10651.16305246945409527645.stgit@bazille.1015granger.net>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 22 Mar 2023 11:49:01 -0400
Message-ID: <CAFX2JfnXmHXPD46tN8oSBX40wh3qJXSDLWAcDGbsTTmTuuMpWw@mail.gmail.com>
Subject: Re: [PATCH v2 23/41] SUNRPC: Add gk5e definitions for RFC 8009
 encryption types
To:     Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Chuck


On Sun, Jan 15, 2023 at 12:23=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote=
:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Fill in entries in the supported_gss_krb5_enctypes array for the
> encryption types defined in RFC 8009. These new enctypes use the
> SHA-256 and SHA-384 message digest algorithms (as defined in
> FIPS-180) instead of the deprecated SHA-1 algorithm, and are thus
> more secure.
>
> Note that NIST has scheduled SHA-1 for deprecation:
>
> https://www.nist.gov/news-events/news/2022/12/nist-retires-sha-1-cryptogr=
aphic-algorithm
>
> Thus these new encryption types are placed under a separate CONFIG
> option to enable distributors to separately introduce support for
> the AES-SHA2 enctypes and deprecate support for the current set of
> AES-SHA1 encryption types as their user space allows.
>
> As this implementation is still a "beta", the default is to not
> build it automatically.
>
> Tested-by: Scott Mayhew <smayhew@redhat.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/gss_krb5.h     |   19 ++++++++++++-
>  net/sunrpc/Kconfig                  |   14 ++++++++++
>  net/sunrpc/auth_gss/gss_krb5_mech.c |   51 +++++++++++++++++++++++++++++=
++++++
>  3 files changed, 82 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_k=
rb5.h
> index 3e97d2a7c87d..8ff397b5c04b 100644
> --- a/include/linux/sunrpc/gss_krb5.h
> +++ b/include/linux/sunrpc/gss_krb5.h
> @@ -54,8 +54,8 @@
>  /* Maximum key length (in bytes) for the supported crypto algorithms */
>  #define GSS_KRB5_MAX_KEYLEN (32)
>
> -/* Maximum checksum function output for the supported crypto algorithms =
*/
> -#define GSS_KRB5_MAX_CKSUM_LEN  (20)
> +/* Maximum checksum function output for the supported enctypes */
> +#define GSS_KRB5_MAX_CKSUM_LEN  (24)

I'm having some problems that I bisected to this patch, specifically
this change to GSS_KRB5_MAX_CKSUM_LEN.  KASAN reports it as a
slab-out-of-bounds in gss_krb5_checksum(), and it can cause my client
to panic when running cthon basic tests with krb5p. I was wondering if
you've seen this?

Anna

Here is what kasan tells me:

[   35.725366] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   35.725373] BUG: KASAN: slab-out-of-bounds in
gss_krb5_checksum+0x4b6/0x630 [rpcsec_gss_krb5]
[   35.725383] Read of size 24 at addr ffff888110cfc1a0 by task mount.nfs/8=
53

[   35.725390] CPU: 2 PID: 853 Comm: mount.nfs Not tainted
6.2.0-ga40cf7530d31+ #37820 4b7d53453529728aac4e973d4ba6a17952148f02
[   35.725395] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 0.0.0 02/06/2015
[   35.725399] Call Trace:
[   35.725401]  <TASK>
[   35.725404]  dump_stack_lvl+0x48/0x60
[   35.725409]  print_report+0x184/0x4a8
[   35.725414]  ? memcpy+0x3c/0x60
[   35.725419]  ? gss_krb5_checksum+0x4b6/0x630 [rpcsec_gss_krb5
2fd8c249acfdf3162b23b30d5eb7af0425d84960]
[   35.725426]  kasan_report+0xc9/0x150
[   35.725431]  ? gss_krb5_checksum+0x4b6/0x630 [rpcsec_gss_krb5
2fd8c249acfdf3162b23b30d5eb7af0425d84960]
[   35.725439]  kasan_check_range+0x13e/0x1c0
[   35.725447]  memcpy+0x23/0x60
[   35.725451]  gss_krb5_checksum+0x4b6/0x630 [rpcsec_gss_krb5
2fd8c249acfdf3162b23b30d5eb7af0425d84960]
[   35.725460]  ? __pfx_gss_krb5_checksum+0x10/0x10 [rpcsec_gss_krb5
2fd8c249acfdf3162b23b30d5eb7af0425d84960]
[   35.725467]  ? memmove+0x3c/0x60
[   35.725472]  gss_krb5_aes_encrypt+0x388/0x7c0 [rpcsec_gss_krb5
2fd8c249acfdf3162b23b30d5eb7af0425d84960]
[   35.725480]  ? __pfx_gss_krb5_aes_encrypt+0x10/0x10
[rpcsec_gss_krb5 2fd8c249acfdf3162b23b30d5eb7af0425d84960]
[   35.725487]  ? memmove+0x3c/0x60
[   35.725491]  gss_krb5_wrap_v2+0x28e/0x3a0 [rpcsec_gss_krb5
2fd8c249acfdf3162b23b30d5eb7af0425d84960]
[   35.725500]  gss_wrap_req_priv+0x3d7/0x1090 [auth_rpcgss
9532107bdb7719d1a30fdcf239028e9e54e0c27c]
[   35.725517]  gss_wrap_req+0x1df/0x250 [auth_rpcgss
9532107bdb7719d1a30fdcf239028e9e54e0c27c]
[   35.725572]  call_encode+0x75a/0x1000 [sunrpc
807a235f89c5b6b32dbda9261e96d6b1ac9ed4f5]
[   35.725626]  ? __pfx_call_encode+0x10/0x10 [sunrpc
807a235f89c5b6b32dbda9261e96d6b1ac9ed4f5]
[   35.725671]  ? __kasan_kmalloc+0xad/0xb0
[   35.725676]  ? xprt_alloc_slot+0x1ca/0x590 [sunrpc
807a235f89c5b6b32dbda9261e96d6b1ac9ed4f5]
[   35.725724]  ? call_allocate+0x30d/0x6b0 [sunrpc
807a235f89c5b6b32dbda9261e96d6b1ac9ed4f5]
[   35.725779]  ? __pfx_call_encode+0x10/0x10 [sunrpc
807a235f89c5b6b32dbda9261e96d6b1ac9ed4f5]
[   35.725829]  __rpc_execute+0x29b/0xcf0 [sunrpc
807a235f89c5b6b32dbda9261e96d6b1ac9ed4f5]
[   35.725885]  ? __pfx___rpc_execute+0x10/0x10 [sunrpc
807a235f89c5b6b32dbda9261e96d6b1ac9ed4f5]
[   35.725936]  ? __pfx_wake_up_bit+0x10/0x10
[   35.725941]  ? _raw_spin_lock+0x85/0xe0
[   35.725945]  rpc_execute+0x21d/0x320 [sunrpc
807a235f89c5b6b32dbda9261e96d6b1ac9ed4f5]
[   35.725997]  rpc_run_task+0x467/0x650 [sunrpc
807a235f89c5b6b32dbda9261e96d6b1ac9ed4f5]
[   35.726044]  nfs4_call_sync_sequence+0x17e/0x2a0 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726095]  ? unwind_get_return_address+0x5e/0xa0
[   35.726100]  ? __pfx_nfs4_call_sync_sequence+0x10/0x10 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726146]  ? stack_trace_save+0x95/0xd0
[   35.726151]  ? __stack_depot_save+0x3f/0x4c0
[   35.726157]  _nfs4_lookup_root.isra.0+0x193/0x200 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726202]  ? __pfx__nfs4_lookup_root.isra.0+0x10/0x10 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726246]  ? kasan_save_stack+0x45/0x60
[   35.726251]  ? nfs_alloc_fattr+0x44/0x210 [nfs
1894ec9cbdec354be2bcab1be6e5e8ab9f92de62]
[   35.726290]  ? nfs4_get_rootfh+0x92/0x290 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726341]  ? nfs4_server_common_setup+0xa4/0x680 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726391]  ? nfs4_create_server+0x8d7/0xf00 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726440]  ? nfs4_try_get_tree+0xd1/0x250 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726488]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   35.726496]  nfs4_lookup_root+0xeb/0x260 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726542]  ? __pfx_nfs4_lookup_root+0x10/0x10 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726589]  nfs4_proc_get_rootfh+0xdc/0x110 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726636]  nfs4_get_rootfh+0xb4/0x290 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726685]  ? __pfx_nfs4_get_rootfh+0x10/0x10 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726733]  ? nfs4_set_client+0x2d8/0x430 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726785]  nfs4_server_common_setup+0xa4/0x680 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726834]  nfs4_create_server+0x8d7/0xf00 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726884]  ? _raw_spin_lock+0x85/0xe0
[   35.726888]  ? __pfx_nfs4_create_server+0x10/0x10 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726937]  ? __module_get+0x31/0xf0
[   35.726942]  nfs4_try_get_tree+0xd1/0x250 [nfsv4
d67fe18359c6743dcd6788d44186185ed97423ee]
[   35.726991]  vfs_get_tree+0x84/0x2c0
[   35.726996]  path_mount+0xa9f/0x1a20
[   35.727001]  ? __pfx_path_mount+0x10/0x10
[   35.727005]  ? user_path_at_empty+0x44/0x60
[   35.727008]  ? kmem_cache_free+0x19e/0x320
[   35.727013]  __x64_sys_mount+0x214/0x280
[   35.727017]  ? __pfx___x64_sys_mount+0x10/0x10
[   35.727020]  ? _raw_spin_lock+0x85/0xe0
[   35.727024]  do_syscall_64+0x5c/0x90
[   35.727029]  ? syscall_exit_to_user_mode+0x1b/0x40
[   35.727032]  ? do_syscall_64+0x6b/0x90
[   35.727036]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   35.727040] RIP: 0033:0x7f1291a5afde
[   35.727044] Code: 48 8b 0d 95 ed 0c 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 62 ed 0c 00 f7 d8 64 89
01 48
[   35.727047] RSP: 002b:00007ffd02e479e8 EFLAGS: 00000246 ORIG_RAX:
00000000000000a5
[   35.727055] RAX: ffffffffffffffda RBX: 00007ffd02e47b90 RCX: 00007f1291a=
5afde
[   35.727058] RDX: 00005565e507c3b0 RSI: 00005565e507b500 RDI: 00005565e50=
7b550
[   35.727060] RBP: 00005565e50824f0 R08: 00005565e50824f0 R09: 00000000000=
00060
[   35.727062] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd02e=
47b90
[   35.727065] R13: 00005565e5082210 R14: 0000000000000003 R15: 00005565e42=
168f8
[   35.727069]  </TASK>

[   35.727073] Allocated by task 853:
[   35.727075]  kasan_save_stack+0x33/0x60
[   35.727079]  kasan_set_track+0x25/0x30
[   35.727082]  __kasan_kmalloc+0xad/0xb0
[   35.727086]  __kmalloc+0x5e/0x160
[   35.727088]  gss_krb5_checksum+0xcf/0x630 [rpcsec_gss_krb5]
[   35.727095]  gss_krb5_aes_encrypt+0x388/0x7c0 [rpcsec_gss_krb5]
[   35.727101]  gss_krb5_wrap_v2+0x28e/0x3a0 [rpcsec_gss_krb5]
[   35.727107]  gss_wrap_req_priv+0x3d7/0x1090 [auth_rpcgss]
[   35.727119]  gss_wrap_req+0x1df/0x250 [auth_rpcgss]
[   35.727131]  call_encode+0x75a/0x1000 [sunrpc]
[   35.727175]  __rpc_execute+0x29b/0xcf0 [sunrpc]
[   35.727227]  rpc_execute+0x21d/0x320 [sunrpc]
[   35.727277]  rpc_run_task+0x467/0x650 [sunrpc]
[   35.727321]  nfs4_call_sync_sequence+0x17e/0x2a0 [nfsv4]
[   35.727365]  _nfs4_lookup_root.isra.0+0x193/0x200 [nfsv4]
[   35.727408]  nfs4_lookup_root+0xeb/0x260 [nfsv4]
[   35.727453]  nfs4_proc_get_rootfh+0xdc/0x110 [nfsv4]
[   35.727498]  nfs4_get_rootfh+0xb4/0x290 [nfsv4]
[   35.727546]  nfs4_server_common_setup+0xa4/0x680 [nfsv4]
[   35.727595]  nfs4_create_server+0x8d7/0xf00 [nfsv4]
[   35.727643]  nfs4_try_get_tree+0xd1/0x250 [nfsv4]
[   35.727690]  vfs_get_tree+0x84/0x2c0
[   35.727694]  path_mount+0xa9f/0x1a20
[   35.727697]  __x64_sys_mount+0x214/0x280
[   35.727701]  do_syscall_64+0x5c/0x90
[   35.727704]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

[   35.727709] The buggy address belongs to the object at ffff888110cfc1a0
                which belongs to the cache kmalloc-32 of size 32
[   35.727712] The buggy address is located 0 bytes inside of
                32-byte region [ffff888110cfc1a0, ffff888110cfc1c0)

[   35.727717] The buggy address belongs to the physical page:
[   35.727721] page:ffffea0004433f00 refcount:1 mapcount:0
mapping:0000000000000000 index:0xffff888110cfce60 pfn:0x110cfc
[   35.727726] flags: 0x2ffff0000000200(slab|node=3D0|zone=3D2|lastcpupid=
=3D0xffff)
[   35.727731] raw: 02ffff0000000200 ffff888100042740 ffffea00044274d0
ffff888100040450
[   35.727734] raw: ffff888110cfce60 0000000000150012 00000001ffffffff
0000000000000000
[   35.727736] page dumped because: kasan: bad access detected
[   35.727740] page_owner tracks the page as allocated
[   35.727741] page last allocated via order 0, migratetype Unmovable,
gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 715, tgid
715 (test2), ts 24589446140, free_ts 24535345796
[   35.727747]  post_alloc_hook+0x118/0x250
[   35.727750]  get_page_from_freelist+0x11ef/0x3a20
[   35.727754]  __alloc_pages+0x1d5/0x440
[   35.727757]  allocate_slab+0x346/0x4a0
[   35.727760]  ___slab_alloc+0x39a/0x9a0
[   35.727763]  __kmem_cache_alloc_node+0x143/0x3d0
[   35.727766]  __kmalloc+0x4d/0x160
[   35.727768]  gss_krb5_checksum+0xcf/0x630 [rpcsec_gss_krb5]
[   35.727775]  gss_krb5_verify_mic_v2+0x2d2/0x4f0 [rpcsec_gss_krb5]
[   35.727780]  gss_validate+0x360/0x700 [auth_rpcgss]
[   35.727792]  rpc_decode_header+0x288/0xcb0 [sunrpc]
[   35.727836]  call_decode+0x3a7/0x780 [sunrpc]
[   35.727880]  __rpc_execute+0x29b/0xcf0 [sunrpc]
[   35.727932]  rpc_execute+0x21d/0x320 [sunrpc]
[   35.727982]  rpc_run_task+0x467/0x650 [sunrpc]
[   35.728026]  nfs4_call_sync_sequence+0x17e/0x2a0 [nfsv4]
[   35.728070] page last free stack trace:
[   35.728072]  free_pcp_prepare+0x66c/0x10e0
[   35.728075]  free_unref_page+0x4e/0x3c0
[   35.728078]  tlb_remove_table_rcu+0x77/0xc0
[   35.728081]  rcu_do_batch+0x34c/0xd00
[   35.728084]  rcu_core+0x447/0xf20
[   35.728086]  __do_softirq+0x1d6/0x5ed

[   35.728091] Memory state around the buggy address:
[   35.728093]  ffff888110cfc080: fc fc fc fc fc fc fc fc fc fc fc fc
fa fb fb fb
[   35.728096]  ffff888110cfc100: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   35.728098] >ffff888110cfc180: fc fc fc fc 00 00 04 fc fc fc fc fc
fc fc fc fc
[   35.728100]                                      ^
[   35.728102]  ffff888110cfc200: fc fc fc fc fc fc fc fc fc fc fc fc
00 00 00 00
[   35.728104]  ffff888110cfc280: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   35.728106] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


>
>  /* Maximum blocksize for the supported crypto algorithms */
>  #define GSS_KRB5_MAX_BLOCKSIZE  (16)
> @@ -160,6 +160,12 @@ enum seal_alg {
>         SEAL_ALG_DES3KD =3D 0x0002
>  };
>
> +/*
> + * These values are assigned by IANA and published via the
> + * subregistry at the link below:
> + *
> + * https://www.iana.org/assignments/kerberos-parameters/kerberos-paramet=
ers.xhtml#kerberos-parameters-2
> + */
>  #define CKSUMTYPE_CRC32                        0x0001
>  #define CKSUMTYPE_RSA_MD4              0x0002
>  #define CKSUMTYPE_RSA_MD4_DES          0x0003
> @@ -170,6 +176,8 @@ enum seal_alg {
>  #define CKSUMTYPE_HMAC_SHA1_DES3       0x000c
>  #define CKSUMTYPE_HMAC_SHA1_96_AES128   0x000f
>  #define CKSUMTYPE_HMAC_SHA1_96_AES256   0x0010
> +#define CKSUMTYPE_HMAC_SHA256_128_AES128       0x0013
> +#define CKSUMTYPE_HMAC_SHA384_192_AES256       0x0014
>  #define CKSUMTYPE_HMAC_MD5_ARCFOUR      -138 /* Microsoft md5 hmac cksum=
type */
>
>  /* from gssapi_err_krb5.h */
> @@ -190,6 +198,11 @@ enum seal_alg {
>
>  /* per Kerberos v5 protocol spec crypto types from the wire.
>   * these get mapped to linux kernel crypto routines.
> + *
> + * These values are assigned by IANA and published via the
> + * subregistry at the link below:
> + *
> + * https://www.iana.org/assignments/kerberos-parameters/kerberos-paramet=
ers.xhtml#kerberos-parameters-1
>   */
>  #define ENCTYPE_NULL            0x0000
>  #define ENCTYPE_DES_CBC_CRC     0x0001 /* DES cbc mode with CRC-32 */
> @@ -203,6 +216,8 @@ enum seal_alg {
>  #define ENCTYPE_DES3_CBC_SHA1   0x0010
>  #define ENCTYPE_AES128_CTS_HMAC_SHA1_96 0x0011
>  #define ENCTYPE_AES256_CTS_HMAC_SHA1_96 0x0012
> +#define ENCTYPE_AES128_CTS_HMAC_SHA256_128     0x0013
> +#define ENCTYPE_AES256_CTS_HMAC_SHA384_192     0x0014
>  #define ENCTYPE_ARCFOUR_HMAC            0x0017
>  #define ENCTYPE_ARCFOUR_HMAC_EXP        0x0018
>  #define ENCTYPE_UNKNOWN         0x01ff
> diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
> index 1135ff362132..b1aa2318e1dc 100644
> --- a/net/sunrpc/Kconfig
> +++ b/net/sunrpc/Kconfig
> @@ -76,6 +76,20 @@ config RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1
>           SHA-1 digests. These include aes128-cts-hmac-sha1-96 and
>           aes256-cts-hmac-sha1-96.
>
> +config RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2
> +       bool "Enable Kerberos enctypes based on AES and SHA-2"
> +       depends on RPCSEC_GSS_KRB5
> +       depends on CRYPTO_CBC && CRYPTO_CTS
> +       depends on CRYPTO_HMAC && CRYPTO_SHA256 && CRYPTO_SHA512
> +       depends on CRYPTO_AES
> +       default n
> +       select RPCSEC_GSS_KRB5_CRYPTOSYSTEM
> +       help
> +         Choose Y to enable the use of Kerberos 5 encryption types
> +         that utilize Advanced Encryption Standard (AES) ciphers and
> +         SHA-2 digests. These include aes128-cts-hmac-sha256-128 and
> +         aes256-cts-hmac-sha384-192.
> +
>  config SUNRPC_DEBUG
>         bool "RPC: Enable dprintk debugging"
>         depends on SUNRPC && SYSCTL
> diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gs=
s_krb5_mech.c
> index ec3cca8fadc5..1951867f3fa8 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_mech.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
> @@ -146,6 +146,57 @@ static const struct gss_krb5_enctype supported_gss_k=
rb5_enctypes[] =3D {
>           .keyed_cksum =3D 1,
>         },
>  #endif
> +
> +#if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2)
> +       /*
> +        * AES-128 with SHA-256 (RFC 8009)
> +        */
> +       {
> +               .etype          =3D ENCTYPE_AES128_CTS_HMAC_SHA256_128,
> +               .ctype          =3D CKSUMTYPE_HMAC_SHA256_128_AES128,
> +               .name           =3D "aes128-cts-hmac-sha256-128",
> +               .encrypt_name   =3D "cts(cbc(aes))",
> +               .aux_cipher     =3D "cbc(aes)",
> +               .cksum_name     =3D "hmac(sha256)",
> +               .cksumlength    =3D BITS2OCTETS(128),
> +               .keyed_cksum    =3D 1,
> +               .keylength      =3D BITS2OCTETS(128),
> +               .Kc_length      =3D BITS2OCTETS(128),
> +               .Ke_length      =3D BITS2OCTETS(128),
> +               .Ki_length      =3D BITS2OCTETS(128),
> +
> +               .import_ctx     =3D gss_krb5_import_ctx_v2,
> +
> +               .get_mic        =3D gss_krb5_get_mic_v2,
> +               .verify_mic     =3D gss_krb5_verify_mic_v2,
> +               .wrap           =3D gss_krb5_wrap_v2,
> +               .unwrap         =3D gss_krb5_unwrap_v2,
> +       },
> +       /*
> +        * AES-256 with SHA-384 (RFC 8009)
> +        */
> +       {
> +               .etype          =3D ENCTYPE_AES256_CTS_HMAC_SHA384_192,
> +               .ctype          =3D CKSUMTYPE_HMAC_SHA384_192_AES256,
> +               .name           =3D "aes256-cts-hmac-sha384-192",
> +               .encrypt_name   =3D "cts(cbc(aes))",
> +               .aux_cipher     =3D "cbc(aes)",
> +               .cksum_name     =3D "hmac(sha384)",
> +               .cksumlength    =3D BITS2OCTETS(192),
> +               .keyed_cksum    =3D 1,
> +               .keylength      =3D BITS2OCTETS(256),
> +               .Kc_length      =3D BITS2OCTETS(192),
> +               .Ke_length      =3D BITS2OCTETS(256),
> +               .Ki_length      =3D BITS2OCTETS(192),
> +
> +               .import_ctx     =3D gss_krb5_import_ctx_v2,
> +
> +               .get_mic        =3D gss_krb5_get_mic_v2,
> +               .verify_mic     =3D gss_krb5_verify_mic_v2,
> +               .wrap           =3D gss_krb5_wrap_v2,
> +               .unwrap         =3D gss_krb5_unwrap_v2,
> +       },
> +#endif
>  };
>
>  /*
>
>
