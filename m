Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73425A7798
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2019 01:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfICXft (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Sep 2019 19:35:49 -0400
Received: from smtprelay0241.hostedemail.com ([216.40.44.241]:58829 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726090AbfICXfs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Sep 2019 19:35:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2927E804AB8A;
        Tue,  3 Sep 2019 23:35:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::,RULES_HIT:1:2:41:355:379:599:800:960:966:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:1801:2194:2196:2199:2200:2393:2525:2559:2566:2570:2682:2685:2703:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4052:4321:4385:4470:4605:5007:6119:7514:7903:8603:8660:9025:9108:10004:11658:12740:13148:13230,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: queen31_6c0423b00a718
X-Filterd-Recvd-Size: 10233
Received: from XPS-9350 (unknown [172.58.30.235])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue,  3 Sep 2019 23:35:41 +0000 (UTC)
Message-ID: <7778af20a8e13e6e906ee3d2030ca6af4ba1c37d.camel@perches.com>
Subject: Re: [PATCH v3] kunit: fix failure to build without printk
From:   Joe Perches <joe@perches.com>
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tim.Bird@sony.com
Date:   Tue, 03 Sep 2019 16:35:09 -0700
In-Reply-To: <20190903232112.181303-1-brendanhiggins@google.com>
References: <20190903232112.181303-1-brendanhiggins@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2019-09-03 at 16:21 -0700, Brendan Higgins wrote:
> Previously KUnit assumed that printk would always be present, which is
> not a valid assumption to make. Fix that by removing call to
> vprintk_emit, and calling printk directly.
> 
> This fixes a build error[1] reported by Randy.
> 
> For context this change comes after much discussion. My first stab[2] at
> this was just to make the KUnit logging code compile out; however, it
> was agreed that if we were going to use vprintk_emit, then vprintk_emit
> should provide a no-op stub, which lead to my second attempt[3]. In
> response to me trying to stub out vprintk_emit, Sergey Senozhatsky
> suggested a way for me to remove our usage of vprintk_emit, which led to
> my third attempt at solving this[4].
> 
> In my previous version of this patch[4], I completely removed
> vprintk_emit, as suggested by Sergey; however, there was a bit of debate
> over whether Sergey's solution was the best. The debate arose due to
> Sergey's version resulting in a checkpatch warning, which resulted in a
> debate over correct printk usage. Joe Perches offered an alternative fix
> which was somewhat less far reaching than what Sergey had suggested and
> importantly relied on continuing to use %pV. Much of the debated
> centered around whether %pV should be widely used, and whether Sergey's
> version would result in object size bloat. Ultimately, we decided to go
> with Sergey's version.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link[1]: https://lore.kernel.org/linux-kselftest/c7229254-0d90-d90e-f3df-5b6d6fc0b51f@infradead.org/
> Link[2]: https://lore.kernel.org/linux-kselftest/20190827174932.44177-1-brendanhiggins@google.com/
> Link[3]: https://lore.kernel.org/linux-kselftest/20190827234835.234473-1-brendanhiggins@google.com/
> Link[4]: https://lore.kernel.org/linux-kselftest/20190828093143.163302-1-brendanhiggins@google.com/
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Tim.Bird@sony.com
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
> 
> Sorry for the long commit message, but given the long discussion (and
> some of the confusion that occurred in the discussion), it seemed
> appropriate to summarize the discussion around this patch up to this
> point (especially since one of the proposed patches was under a separate
> patch subject).
> 
> No changes have been made to this patch since v2, other than the commit
> log.
[]
> diff --git a/include/kunit/test.h b/include/kunit/test.h
[]
> @@ -339,9 +339,8 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
>  
>  void kunit_cleanup(struct kunit *test);
>  
> -void __printf(3, 4) kunit_printk(const char *level,
> -				 const struct kunit *test,
> -				 const char *fmt, ...);
> +#define kunit_print_level(KERN_LEVEL, test, fmt, ...) \
> +	printk(KERN_LEVEL "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)

Non trivial notes:

Please do not use KERN_LEVEL as a macro argument.
It would just be a source of possible confusion.

Please use level or lvl like nearly every other macro
that does this uses.

And there is nothing wrong with using kunit_printk and it's
not necessary to use an odd name like kunit_printk_level.

$ git grep -P 'define\s+\w+_printk\(.*\b(level|lvl)'
drivers/block/drbd/drbd_int.h:#define drbd_printk(level, obj, fmt, args...) \
drivers/edac/amd76x_edac.c:#define amd76x_printk(level, fmt, arg...) \
drivers/edac/amd76x_edac.c:#define amd76x_mc_printk(mci, level, fmt, arg...) \
drivers/edac/cpc925_edac.c:#define cpc925_printk(level, fmt, arg...) \
drivers/edac/cpc925_edac.c:#define cpc925_mc_printk(mci, level, fmt, arg...) \
drivers/edac/e752x_edac.c:#define e752x_printk(level, fmt, arg...) \
drivers/edac/e752x_edac.c:#define e752x_mc_printk(mci, level, fmt, arg...) \
drivers/edac/e7xxx_edac.c:#define e7xxx_printk(level, fmt, arg...) \
drivers/edac/e7xxx_edac.c:#define e7xxx_mc_printk(mci, level, fmt, arg...) \
drivers/edac/edac_mc.h:#define edac_printk(level, prefix, fmt, arg...) \
drivers/edac/edac_mc.h:#define edac_mc_printk(mci, level, fmt, arg...) \
drivers/edac/edac_mc.h:#define edac_mc_chipset_printk(mci, level, prefix, fmt, arg...) \
drivers/edac/edac_mc.h:#define edac_device_printk(ctl, level, fmt, arg...) \
drivers/edac/edac_mc.h:#define edac_pci_printk(ctl, level, fmt, arg...) \
drivers/edac/fsl_ddr_edac.h:#define fsl_mc_printk(mci, level, fmt, arg...) \
drivers/edac/i10nm_base.c:#define i10nm_printk(level, fmt, arg...)      \
drivers/edac/i5000_edac.c:#define i5000_printk(level, fmt, arg...) \
drivers/edac/i5000_edac.c:#define i5000_mc_printk(mci, level, fmt, arg...) \
drivers/edac/i5400_edac.c:#define i5400_printk(level, fmt, arg...) \
drivers/edac/i5400_edac.c:#define i5400_mc_printk(mci, level, fmt, arg...) \
drivers/edac/i7300_edac.c:#define i7300_printk(level, fmt, arg...) \
drivers/edac/i7300_edac.c:#define i7300_mc_printk(mci, level, fmt, arg...) \
drivers/edac/i7core_edac.c:#define i7core_printk(level, fmt, arg...)                    \
drivers/edac/i7core_edac.c:#define i7core_mc_printk(mci, level, fmt, arg...)            \
drivers/edac/i82860_edac.c:#define i82860_printk(level, fmt, arg...) \
drivers/edac/i82860_edac.c:#define i82860_mc_printk(mci, level, fmt, arg...) \
drivers/edac/i82875p_edac.c:#define i82875p_printk(level, fmt, arg...) \
drivers/edac/i82875p_edac.c:#define i82875p_mc_printk(mci, level, fmt, arg...) \
drivers/edac/i82975x_edac.c:#define i82975x_printk(level, fmt, arg...) \
drivers/edac/i82975x_edac.c:#define i82975x_mc_printk(mci, level, fmt, arg...) \
drivers/edac/ie31200_edac.c:#define ie31200_printk(level, fmt, arg...) \
drivers/edac/mpc85xx_edac.h:#define mpc85xx_printk(level, fmt, arg...) \
drivers/edac/mv64x60_edac.h:#define mv64x60_printk(level, fmt, arg...) \
drivers/edac/mv64x60_edac.h:#define mv64x60_mc_printk(mci, level, fmt, arg...) \
drivers/edac/pnd2_edac.c:#define pnd2_printk(level, fmt, arg...)                        \
drivers/edac/pnd2_edac.c:#define pnd2_mc_printk(mci, level, fmt, arg...)        \
drivers/edac/ppc4xx_edac.c:#define ppc4xx_edac_printk(level, fmt, arg...) \
drivers/edac/ppc4xx_edac.c:#define ppc4xx_edac_mc_printk(level, mci, fmt, arg...) \
drivers/edac/r82600_edac.c:#define r82600_printk(level, fmt, arg...) \
drivers/edac/r82600_edac.c:#define r82600_mc_printk(mci, level, fmt, arg...) \
drivers/edac/sb_edac.c:#define sbridge_printk(level, fmt, arg...)                       \
drivers/edac/sb_edac.c:#define sbridge_mc_printk(mci, level, fmt, arg...)               \
drivers/edac/skx_base.c:#define skx_printk(level, fmt, arg...)                  \
drivers/edac/skx_base.c:#define skx_mc_printk(mci, level, fmt, arg...)          \
drivers/edac/skx_common.h:#define skx_printk(level, fmt, arg...)                        \
drivers/edac/skx_common.h:#define skx_mc_printk(mci, level, fmt, arg...)                \
drivers/infiniband/hw/usnic/usnic_log.h:#define usnic_printk(lvl, args...) \
drivers/infiniband/ulp/ipoib/ipoib.h:#define ipoib_printk(level, priv, format, arg...)  \
drivers/input/mouse/psmouse.h:#define psmouse_printk(level, psmouse, format, ...)       \
drivers/media/tuners/mc44s803.c:#define mc_printk(level, format, arg...)        \
drivers/media/tuners/tda18271-priv.h:#define tda_printk(st, lvl, fmt, arg...)                   \
drivers/media/usb/uvc/uvcvideo.h:#define uvc_printk(level, msg...) \
drivers/net/ethernet/freescale/ucc_geth.c:#define ugeth_printk(level, format, arg...)  \
drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cpp.h:#define nfp_printk(level, cpp, fmt, args...) \
drivers/net/phy/phylink.c:#define phylink_printk(level, pl, fmt, ...) \
drivers/scsi/ipr.h:#define ipr_res_printk(level, ioa_cfg, bus, target, lun, fmt, ...) \
drivers/scsi/ipr.h:#define ipr_ra_printk(level, ioa_cfg, ra, fmt, ...) \
drivers/scsi/qla4xxx/ql4_def.h:#define ql4_printk(level, ha, format, arg...) \
drivers/scsi/sym53c8xx_2/sym_hipd.c:#define sym_printk(lvl, tp, cp, fmt, v...) do { \
drivers/usb/atm/usbatm.h:#define atm_printk(level, instance, format, arg...)    \
include/linux/hid.h:#define hid_printk(level, hid, fmt, arg...)         \
include/linux/netdevice.h:#define netif_printk(priv, type, level, dev, fmt, args...)    \
include/linux/pci.h:#define pci_printk(level, pdev, fmt, arg...) \
include/media/v4l2-common.h:#define v4l_printk(level, name, adapter, addr, fmt, arg...) \
include/media/v4l2-common.h:#define v4l_client_printk(level, client, fmt, arg...)                           \
include/media/v4l2-common.h:#define v4l2_printk(level, dev, fmt, arg...) \
include/net/cfg80211.h:#define wiphy_printk(level, wiphy, format, args...)              \
include/sound/core.h:#define __snd_printk(level, file, line, format, ...) \
net/bridge/br_private.h:#define br_printk(level, br, format, args...)   \


