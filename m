Return-Path: <linux-kselftest+bounces-36899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F75AFF73B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 05:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3DD5A4AF3
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 03:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD6C27F727;
	Thu, 10 Jul 2025 03:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="FHzujBSc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GxTeLlfT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F82E36E0;
	Thu, 10 Jul 2025 03:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116485; cv=none; b=njszUTXzNgznpoBS/EzkOfepYETU8qtEhZI9GakNwzNUda726tltG/1LKvzEFxr4dOvGmBu6DY9bHM5XW4gQk86j5PD3eAxInhhH2r1Eyj+OjrN4e6GnjKN9rDzC+KkEpiwK+5/EewwwfMV+tKUEHv72fsuHK4xFKOWefJXjuLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116485; c=relaxed/simple;
	bh=fZZ65HoK2FR5aa2/mMDmNxe14yqcfCwzkX/Sjwb1H7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGCxBEtjai/lVGPgFKwhpetUj5R2ZMNWottMWwqHgVE1al0kCH+r50BY2hBrxAdMkakvL2PFZCYQKozKlAFALqaSiPlGTv23MQ+EOqg+JyoMXmcTHz8s86T8fvmlgNFYxncdxSkH4SUvNiT1W6VXTjPnH7ppx+HWJKZpy1bsg2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=FHzujBSc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GxTeLlfT; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 502F01400209;
	Wed,  9 Jul 2025 23:01:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 09 Jul 2025 23:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752116481; x=1752202881; bh=gg85xa7w5q
	RdyjV+YGztgSsXrtWr7iwCqJ/09LaFFWA=; b=FHzujBScv6ZIBxX6RU9/e7z4d6
	WiL9KPo6wCKsivbfyk8M8m05vm6gp4f/zywRV3ODYlvyh0bykpA35qrSwIpjMPP7
	obtNUHyArLN5h+jQGzdqLLrrQs5U2UwrxeU3kvDyClSiE8T8z6J5jgDl/locCAEp
	YRC4ruE1ffK525az9QLTNnu16fwx4JwK4LbYZxnqzjEVIeJkyNJZwFq0nWAhNv1d
	ugTUzJf2PIfEwfGV8d0Bf0cVjtL/YIdheHfIDdPTHayE4QQOBm143dopn2bt1K4o
	hWSRmBHg8TfuPQvgtKMMyD6SjcvmcETzWEnmwLtClvxoxSaik6c9+/5CN5EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752116481; x=1752202881; bh=gg85xa7w5qRdyjV+YGztgSsXrtWr7iwCqJ/
	09LaFFWA=; b=GxTeLlfT52TjVl/43v9I5gZjy6d1uHAcizDnp6ablb1nZi4T0RL
	iB+sjxZ645u0RjkyzX3APp+AoL0YvPqfX90dVu64RVtAw76qzaKYDhVAHzcgi9TT
	5xOUZ826IkXHtct+cI17ur+hHwCls5hVj0AzJ+lA3Gh5EjMb5b1Yqrb2QJB83rnA
	2ORvbao90hKApfJ/ejJyd5pkYBcNBBHRmtsrR6hw5Q7xByYX40nNwCWND4IxfoHN
	fP/qcXruhwg/mK3BtXsThkC1uoJSCJw8+0mzglpr76spyg4rS3fO1bUJ4SqsUI/c
	I3vGittkPJ8r2zoufkkwfhOBr+vPeC8oDNQ==
X-ME-Sender: <xms:AS1vaIPM7Uye2RnypZnws3jBt6agY9pAXkrPk6l7caIvaGoMtqaqaA>
    <xme:AS1vaGU8ypeoiAfZo5MlST0XR_NhDcwkSMttsW7gajbsy4wFTmHq2lvpC-gzKdUUE
    usSCRPQ351l8UHHzBg>
X-ME-Received: <xmr:AS1vaE15SJUm9VtNkrVlsmD2gm5gaFvWyyyMhNKi6482_goLSLUs8FWMV9Ut93MgAx4whrjOAhX8UPLQLv3brFozkYJX57OvNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrvghtvghrucfj
    uhhtthgvrhgvrhcuoehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvtheqne
    cuggftrfgrthhtvghrnhepleeiueegieetveetfeelvdevhffffefhtedtvdduffduffei
    geeikeffueeukeehnecuffhomhgrihhnpehgnhhurdhorhhgpdgpkhgvrhhnvghlpghish
    gprhgvrgguhidrihhspdhtvghsthdrrghpphhlvgdpuggvvhhitggvrdhsohhnhidpthgv
    shhtrdhsohhnhienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvthdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhhtihhssheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AS1vaMqvFjHanjqSKHnUgaflu7S3Sx_5qpbDCkG6joQUGJL8jL66og>
    <xmx:AS1vaDXDfxF6sAFFfjggg-Qjefe6jhv5tEp0V4FLnjwPaWwYX87dsg>
    <xmx:AS1vaPaPWG_buhYHqOtadT8cYxgHUNvHUCkSD56jn2DA-1K-moTXvQ>
    <xmx:AS1vaIevIVfm5DLW19zwNG5HqkGMhX5y7T1hsF4jgriPNbeQCagS5g>
    <xmx:AS1vaKj1MKvD3znyLZN11pUNX60qrWRpgJm3ovhdbSDZxyzmMsYM2r-4>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 23:01:18 -0400 (EDT)
Date: Thu, 10 Jul 2025 12:58:49 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests/hid: sync the python tests to hid-tools 0.8
Message-ID: <20250710025849.GA11111@quokka>
References: <20250709-wip-fix-ci-v1-0-b7df4c271cf8@kernel.org>
 <20250709-wip-fix-ci-v1-2-b7df4c271cf8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-wip-fix-ci-v1-2-b7df4c271cf8@kernel.org>

On Wed, Jul 09, 2025 at 11:08:50AM +0200, Benjamin Tissoires wrote:
> Instead of backporting one by one each commits, let's pull them in bulk
> and reference the hid-tools project for a detailed history.

s/reference/refer to/ ?

otherwise, series:

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
  Peter

> 
> The short summary is:
> - make use of dataclass when possible, to avoid tuples
> - wacom: remove unused uhdev parameter
> - various small fixes not worth mentioning
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  tools/testing/selftests/hid/tests/base.py          | 46 ++++++++++++++--------
>  tools/testing/selftests/hid/tests/base_device.py   | 30 ++++++++------
>  .../selftests/hid/tests/test_apple_keyboard.py     |  3 +-
>  tools/testing/selftests/hid/tests/test_gamepad.py  |  3 +-
>  .../selftests/hid/tests/test_ite_keyboard.py       |  3 +-
>  .../testing/selftests/hid/tests/test_multitouch.py |  2 +-
>  tools/testing/selftests/hid/tests/test_sony.py     |  7 ++--
>  tools/testing/selftests/hid/tests/test_tablet.py   |  7 ++--
>  .../selftests/hid/tests/test_wacom_generic.py      | 11 +++---
>  9 files changed, 69 insertions(+), 43 deletions(-)
> 
> diff --git a/tools/testing/selftests/hid/tests/base.py b/tools/testing/selftests/hid/tests/base.py
> index 3a465768e507dd8fe540c60ebc2dd3a133e6f19b..5175cf235b2f877b90a942139318a0cd3845b6aa 100644
> --- a/tools/testing/selftests/hid/tests/base.py
> +++ b/tools/testing/selftests/hid/tests/base.py
> @@ -5,6 +5,7 @@
>  # Copyright (c) 2017 Benjamin Tissoires <benjamin.tissoires@gmail.com>
>  # Copyright (c) 2017 Red Hat, Inc.
>  
> +import dataclasses
>  import libevdev
>  import os
>  import pytest
> @@ -145,6 +146,18 @@ class UHIDTestDevice(BaseDevice):
>          self.name = name
>  
>  
> +@dataclasses.dataclass
> +class HidBpf:
> +    object_name: str
> +    has_rdesc_fixup: bool
> +
> +
> +@dataclasses.dataclass
> +class KernelModule:
> +    driver_name: str
> +    module_name: str
> +
> +
>  class BaseTestCase:
>      class TestUhid(object):
>          syn_event = libevdev.InputEvent(libevdev.EV_SYN.SYN_REPORT)  # type: ignore
> @@ -155,20 +168,20 @@ class BaseTestCase:
>  
>          # List of kernel modules to load before starting the test
>          # if any module is not available (not compiled), the test will skip.
> -        # Each element is a tuple '(kernel driver name, kernel module)',
> -        # for example ("playstation", "hid-playstation")
> -        kernel_modules: List[Tuple[str, str]] = []
> +        # Each element is a KernelModule object, for example
> +        # KernelModule("playstation", "hid-playstation")
> +        kernel_modules: List[KernelModule] = []
>  
>          # List of in kernel HID-BPF object files to load
>          # before starting the test
>          # Any existing pre-loaded HID-BPF module will be removed
>          # before the ones in this list will be manually loaded.
> -        # Each Element is a tuple '(hid_bpf_object, rdesc_fixup_present)',
> -        # for example '("xppen-ArtistPro16Gen2.bpf.o", True)'
> -        # If 'rdesc_fixup_present' is True, the test needs to wait
> +        # Each Element is a HidBpf object, for example
> +        # 'HidBpf("xppen-ArtistPro16Gen2.bpf.o", True)'
> +        # If 'has_rdesc_fixup' is True, the test needs to wait
>          # for one unbind and rebind before it can be sure the kernel is
>          # ready
> -        hid_bpfs: List[Tuple[str, bool]] = []
> +        hid_bpfs: List[HidBpf] = []
>  
>          def assertInputEventsIn(self, expected_events, effective_events):
>              effective_events = effective_events.copy()
> @@ -232,25 +245,26 @@ class BaseTestCase:
>  
>          @pytest.fixture()
>          def load_kernel_module(self):
> -            for kernel_driver, kernel_module in self.kernel_modules:
> -                self._load_kernel_module(kernel_driver, kernel_module)
> +            for k in self.kernel_modules:
> +                self._load_kernel_module(k.driver_name, k.module_name)
>              yield
>  
>          def load_hid_bpfs(self):
> +            # this function will only work when run in the kernel tree
>              script_dir = Path(os.path.dirname(os.path.realpath(__file__)))
>              root_dir = (script_dir / "../../../../..").resolve()
>              bpf_dir = root_dir / "drivers/hid/bpf/progs"
>  
> +            if not bpf_dir.exists():
> +                pytest.skip("looks like we are not in the kernel tree, skipping")
> +
>              udev_hid_bpf = shutil.which("udev-hid-bpf")
>              if not udev_hid_bpf:
>                  pytest.skip("udev-hid-bpf not found in $PATH, skipping")
>  
> -            wait = False
> -            for _, rdesc_fixup in self.hid_bpfs:
> -                if rdesc_fixup:
> -                    wait = True
> +            wait = any(b.has_rdesc_fixup for b in self.hid_bpfs)
>  
> -            for hid_bpf, _ in self.hid_bpfs:
> +            for hid_bpf in self.hid_bpfs:
>                  # We need to start `udev-hid-bpf` in the background
>                  # and dispatch uhid events in case the kernel needs
>                  # to fetch features on the device
> @@ -260,13 +274,13 @@ class BaseTestCase:
>                          "--verbose",
>                          "add",
>                          str(self.uhdev.sys_path),
> -                        str(bpf_dir / hid_bpf),
> +                        str(bpf_dir / hid_bpf.object_name),
>                      ],
>                  )
>                  while process.poll() is None:
>                      self.uhdev.dispatch(1)
>  
> -                if process.poll() != 0:
> +                if process.returncode != 0:
>                      pytest.fail(
>                          f"Couldn't insert hid-bpf program '{hid_bpf}', marking the test as failed"
>                      )
> diff --git a/tools/testing/selftests/hid/tests/base_device.py b/tools/testing/selftests/hid/tests/base_device.py
> index e0515be97f83a4b5ff8ad47db15284365f7154dc..e13035fe1deb4c2ee5fd729d43c619bdd759c138 100644
> --- a/tools/testing/selftests/hid/tests/base_device.py
> +++ b/tools/testing/selftests/hid/tests/base_device.py
> @@ -18,6 +18,7 @@
>  # You should have received a copy of the GNU General Public License
>  # along with this program.  If not, see <http://www.gnu.org/licenses/>.
>  
> +import dataclasses
>  import fcntl
>  import functools
>  import libevdev
> @@ -104,6 +105,12 @@ class PowerSupply(object):
>          return self._type.str_value
>  
>  
> +@dataclasses.dataclass
> +class HidReadiness:
> +    is_ready: bool = False
> +    count: int = 0
> +
> +
>  class HIDIsReady(object):
>      """
>      Companion class that binds to a kernel mechanism
> @@ -115,18 +122,18 @@ class HIDIsReady(object):
>      def __init__(self: "HIDIsReady", uhid: UHIDDevice) -> None:
>          self.uhid = uhid
>  
> -    def is_ready(self: "HIDIsReady") -> bool:
> +    def is_ready(self: "HIDIsReady") -> HidReadiness:
>          """
>          Overwrite in subclasses: should return True or False whether
>          the attached uhid device is ready or not.
>          """
> -        return False
> +        return HidReadiness()
>  
>  
>  class UdevHIDIsReady(HIDIsReady):
>      _pyudev_context: ClassVar[Optional[pyudev.Context]] = None
>      _pyudev_monitor: ClassVar[Optional[pyudev.Monitor]] = None
> -    _uhid_devices: ClassVar[Dict[int, Tuple[bool, int]]] = {}
> +    _uhid_devices: ClassVar[Dict[int, HidReadiness]] = {}
>  
>      def __init__(self: "UdevHIDIsReady", uhid: UHIDDevice) -> None:
>          super().__init__(uhid)
> @@ -157,18 +164,19 @@ class UdevHIDIsReady(HIDIsReady):
>  
>              id = int(event.sys_path.strip().split(".")[-1], 16)
>  
> -            device_ready, count = cls._uhid_devices.get(id, (False, 0))
> +            readiness = cls._uhid_devices.setdefault(id, HidReadiness())
>  
>              ready = event.action == "bind"
> -            if not device_ready and ready:
> -                count += 1
> -            cls._uhid_devices[id] = (ready, count)
> +            if not readiness.is_ready and ready:
> +                readiness.count += 1
> +
> +            readiness.is_ready = ready
>  
> -    def is_ready(self: "UdevHIDIsReady") -> Tuple[bool, int]:
> +    def is_ready(self: "UdevHIDIsReady") -> HidReadiness:
>          try:
>              return self._uhid_devices[self.uhid.hid_id]
>          except KeyError:
> -            return (False, 0)
> +            return HidReadiness()
>  
>  
>  class EvdevMatch(object):
> @@ -322,11 +330,11 @@ class BaseDevice(UHIDDevice):
>  
>      @property
>      def kernel_is_ready(self: "BaseDevice") -> bool:
> -        return self._kernel_is_ready.is_ready()[0] and self.started
> +        return self._kernel_is_ready.is_ready().is_ready and self.started
>  
>      @property
>      def kernel_ready_count(self: "BaseDevice") -> int:
> -        return self._kernel_is_ready.is_ready()[1]
> +        return self._kernel_is_ready.is_ready().count
>  
>      @property
>      def input_nodes(self: "BaseDevice") -> List[EvdevDevice]:
> diff --git a/tools/testing/selftests/hid/tests/test_apple_keyboard.py b/tools/testing/selftests/hid/tests/test_apple_keyboard.py
> index f81071d461663b36da8f48d75e7c178ffc145688..0e17588b945c222d1b52b944eebf0719ed7fa3fc 100644
> --- a/tools/testing/selftests/hid/tests/test_apple_keyboard.py
> +++ b/tools/testing/selftests/hid/tests/test_apple_keyboard.py
> @@ -8,13 +8,14 @@
>  
>  from .test_keyboard import ArrayKeyboard, TestArrayKeyboard
>  from hidtools.util import BusType
> +from . import base
>  
>  import libevdev
>  import logging
>  
>  logger = logging.getLogger("hidtools.test.apple-keyboard")
>  
> -KERNEL_MODULE = ("apple", "hid-apple")
> +KERNEL_MODULE = base.KernelModule("apple", "hid-apple")
>  
>  
>  class KbdData(object):
> diff --git a/tools/testing/selftests/hid/tests/test_gamepad.py b/tools/testing/selftests/hid/tests/test_gamepad.py
> index 8d5b5ffdae49505c213602e01cd6d92ee9eb83ca..6121978059311ef52ba83c91d39a08b522da84f2 100644
> --- a/tools/testing/selftests/hid/tests/test_gamepad.py
> +++ b/tools/testing/selftests/hid/tests/test_gamepad.py
> @@ -12,6 +12,7 @@ import pytest
>  
>  from .base_gamepad import BaseGamepad, JoystickGamepad, AxisMapping
>  from hidtools.util import BusType
> +from .base import HidBpf
>  
>  import logging
>  
> @@ -654,7 +655,7 @@ class TestAsusGamepad(BaseTest.TestGamepad):
>  
>  
>  class TestRaptorMach2Joystick(BaseTest.TestGamepad):
> -    hid_bpfs = [("FR-TEC__Raptor-Mach-2.bpf.o", True)]
> +    hid_bpfs = [HidBpf("FR-TEC__Raptor-Mach-2.bpf.o", True)]
>  
>      def create_device(self):
>          return RaptorMach2Joystick(
> diff --git a/tools/testing/selftests/hid/tests/test_ite_keyboard.py b/tools/testing/selftests/hid/tests/test_ite_keyboard.py
> index 38550c167baea440d2dc869d719dbea010ff7639..f695eaad1648e7ea48873725740ea4daf1f9203e 100644
> --- a/tools/testing/selftests/hid/tests/test_ite_keyboard.py
> +++ b/tools/testing/selftests/hid/tests/test_ite_keyboard.py
> @@ -11,10 +11,11 @@ from hidtools.util import BusType
>  
>  import libevdev
>  import logging
> +from . import base
>  
>  logger = logging.getLogger("hidtools.test.ite-keyboard")
>  
> -KERNEL_MODULE = ("itetech", "hid_ite")
> +KERNEL_MODULE = base.KernelModule("itetech", "hid_ite")
>  
>  
>  class KbdData(object):
> diff --git a/tools/testing/selftests/hid/tests/test_multitouch.py b/tools/testing/selftests/hid/tests/test_multitouch.py
> index 4265012231c660f4c97e4bff0feec324dd9115b6..5d2ffa3d59777e3cd93d1d7aebabc2a6b7ecb42a 100644
> --- a/tools/testing/selftests/hid/tests/test_multitouch.py
> +++ b/tools/testing/selftests/hid/tests/test_multitouch.py
> @@ -17,7 +17,7 @@ import time
>  
>  logger = logging.getLogger("hidtools.test.multitouch")
>  
> -KERNEL_MODULE = ("hid-multitouch", "hid_multitouch")
> +KERNEL_MODULE = base.KernelModule("hid-multitouch", "hid_multitouch")
>  
>  
>  def BIT(x):
> diff --git a/tools/testing/selftests/hid/tests/test_sony.py b/tools/testing/selftests/hid/tests/test_sony.py
> index 7e52c28e59c5c210e081579f7047a368c16063ce..7fd3a8e6137d0b404b544f7b886ba4783f81faf1 100644
> --- a/tools/testing/selftests/hid/tests/test_sony.py
> +++ b/tools/testing/selftests/hid/tests/test_sony.py
> @@ -7,6 +7,7 @@
>  #
>  
>  from .base import application_matches
> +from .base import KernelModule
>  from .test_gamepad import BaseTest
>  from hidtools.device.sony_gamepad import (
>      PS3Controller,
> @@ -24,9 +25,9 @@ import pytest
>  
>  logger = logging.getLogger("hidtools.test.sony")
>  
> -PS3_MODULE = ("sony", "hid_sony")
> -PS4_MODULE = ("playstation", "hid_playstation")
> -PS5_MODULE = ("playstation", "hid_playstation")
> +PS3_MODULE = KernelModule("sony", "hid_sony")
> +PS4_MODULE = KernelModule("playstation", "hid_playstation")
> +PS5_MODULE = KernelModule("playstation", "hid_playstation")
>  
>  
>  class SonyBaseTest:
> diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
> index 52fb22cac91e86f85b00a312895c98e6379f02ad..50d5699812bbad171f07386d1f914c3b8da9ac5b 100644
> --- a/tools/testing/selftests/hid/tests/test_tablet.py
> +++ b/tools/testing/selftests/hid/tests/test_tablet.py
> @@ -10,6 +10,7 @@ from . import base
>  import copy
>  from enum import Enum
>  from hidtools.util import BusType
> +from .base import HidBpf
>  import libevdev
>  import logging
>  import pytest
> @@ -1472,7 +1473,7 @@ class TestGoodix_27c6_0e00(BaseTest.TestTablet):
>  
>  
>  class TestXPPen_ArtistPro16Gen2_28bd_095b(BaseTest.TestTablet):
> -    hid_bpfs = [("XPPen__ArtistPro16Gen2.bpf.o", True)]
> +    hid_bpfs = [HidBpf("XPPen__ArtistPro16Gen2.bpf.o", True)]
>  
>      def create_device(self):
>          dev = XPPen_ArtistPro16Gen2_28bd_095b(
> @@ -1484,7 +1485,7 @@ class TestXPPen_ArtistPro16Gen2_28bd_095b(BaseTest.TestTablet):
>  
>  
>  class TestXPPen_Artist24_28bd_093a(BaseTest.TestTablet):
> -    hid_bpfs = [("XPPen__Artist24.bpf.o", True)]
> +    hid_bpfs = [HidBpf("XPPen__Artist24.bpf.o", True)]
>  
>      def create_device(self):
>          return XPPen_Artist24_28bd_093a(
> @@ -1495,7 +1496,7 @@ class TestXPPen_Artist24_28bd_093a(BaseTest.TestTablet):
>  
>  
>  class TestHuion_Kamvas_Pro_19_256c_006b(BaseTest.TestTablet):
> -    hid_bpfs = [("Huion__Kamvas-Pro-19.bpf.o", True)]
> +    hid_bpfs = [HidBpf("Huion__Kamvas-Pro-19.bpf.o", True)]
>  
>      def create_device(self):
>          return Huion_Kamvas_Pro_19_256c_006b(
> diff --git a/tools/testing/selftests/hid/tests/test_wacom_generic.py b/tools/testing/selftests/hid/tests/test_wacom_generic.py
> index 5cbc0cc9308f653b817e54a95f8b53a83782f105..2d6d04f0ff80bea46dc6c61c2b3a43383be6ac50 100644
> --- a/tools/testing/selftests/hid/tests/test_wacom_generic.py
> +++ b/tools/testing/selftests/hid/tests/test_wacom_generic.py
> @@ -40,7 +40,7 @@ import logging
>  
>  logger = logging.getLogger("hidtools.test.wacom")
>  
> -KERNEL_MODULE = ("wacom", "wacom")
> +KERNEL_MODULE = base.KernelModule("wacom", "wacom")
>  
>  
>  class ProximityState(Enum):
> @@ -894,7 +894,7 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest
>          """
>          return [self.make_contact(id, t) for id in range(0, n)]
>  
> -    def assert_contact(self, uhdev, evdev, contact_ids, t=0):
> +    def assert_contact(self, evdev, contact_ids, t=0):
>          """
>          Assert properties of a contact generated by make_contact.
>          """
> @@ -916,12 +916,12 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest
>              assert evdev.slots[slot_num][libevdev.EV_ABS.ABS_MT_POSITION_X] == x
>              assert evdev.slots[slot_num][libevdev.EV_ABS.ABS_MT_POSITION_Y] == y
>  
> -    def assert_contacts(self, uhdev, evdev, data, t=0):
> +    def assert_contacts(self, evdev, data, t=0):
>          """
>          Assert properties of a list of contacts generated by make_contacts.
>          """
>          for contact_ids in data:
> -            self.assert_contact(uhdev, evdev, contact_ids, t)
> +            self.assert_contact(evdev, contact_ids, t)
>  
>      def test_contact_id_0(self):
>          """
> @@ -998,7 +998,6 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest
>          assert libevdev.InputEvent(libevdev.EV_KEY.BTN_TOUCH, 1) in events
>  
>          self.assert_contacts(
> -            uhdev,
>              evdev,
>              [
>                  self.ContactIds(contact_id=0, tracking_id=-1, slot_num=None),
> @@ -1032,7 +1031,7 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest
>              self.debug_reports(r, uhdev, events)
>  
>              ids = [x[0] for x in state]
> -            self.assert_contacts(uhdev, evdev, ids, t)
> +            self.assert_contacts(evdev, ids, t)
>  
>              t += 1
>  
> 
> -- 
> 2.49.0
> 

